import json
import os
import logging
import requests
import base64

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def lambda_handler(event, context):
    try:
        BIRD_APP_URL = os.environ['BIRD_APP_URL']
        BIRD_USER = os.environ['BIRD_USER']
        BIRD_PASS = os.environ['BIRD_PASS']
        ILLUMINATI_API_URL = os.environ['ILLUMINATI_API_URL']
    except KeyError as e:
        logger.error(f"Missing environment variable: {e}")
        return {'statusCode': 500, 'body': json.dumps(f"Configuration Error: Missing {e}")}

    bird_name = "BlueJay"
    bird_filename = "bluejay.jpg"
    bird_location = "Central_Park"

    LOGIN_URL = f"{BIRD_APP_URL}/auth/login"
    CREATE_POST_URL = f"{BIRD_APP_URL}/posts/create"
    ENTRY_PASS_URL = f"{ILLUMINATI_API_URL}/api/password/new_entry_password/"

    session = requests.Session()

    try:
        logger.info(f"1. Logging into Birdwatching App: {LOGIN_URL}")
        login_payload = {'username': BIRD_USER, 'password': BIRD_PASS}

        login_resp = session.post(LOGIN_URL, data=login_payload, timeout=10)
        login_resp.raise_for_status()

        if not session.cookies:
            logger.warning("Login successful but no cookies received.")
            return {'statusCode': 401, 'body': json.dumps('Birdwatching Login Failed: No Session')}

        logger.info(f"2. Posting Bird to: {CREATE_POST_URL}")

        # Path handling: The image is in the same directory as this script in the Lambda environment
        image_path = os.path.join(os.path.dirname(__file__), bird_filename)

        if not os.path.exists(image_path):
            logger.error(f"Image file not found at: {image_path}")
            return {'statusCode': 500, 'body': json.dumps("Image file missing in deployment")}

        with open(image_path, 'rb') as image_file:
            image_data = image_file.read()

        files = {'image': (bird_filename, image_data, 'image/jpeg')}
        data = {'location': bird_location}

        post_resp = session.post(CREATE_POST_URL, data=data, files=files, timeout=15)
        post_resp.raise_for_status()
        logger.info("Bird posted successfully.")

        logger.info(f"3. Triggering Illuminati Endpoint: {ENTRY_PASS_URL}")
        new_password_value = f"{bird_name}-{bird_location}"
        illuminati_payload = {"entry_password": new_password_value}

        entry_resp = requests.post(ENTRY_PASS_URL, json=illuminati_payload, timeout=10)

        if entry_resp.status_code == 200:
            logger.info("Illuminati password trigger successful.")
            return {
                'statusCode': 200,
                'body': json.dumps({
                    'message': 'Workflow complete',
                    'generated_password': new_password_value
                })
            }
        else:
            logger.error(f"Illuminati trigger failed: {entry_resp.status_code} - {entry_resp.text}")
            return {
                'statusCode': entry_resp.status_code,
                'body': json.dumps(f"Illuminati Error: {entry_resp.text}")
            }

    except requests.RequestException as e:
        logger.error(f"Network Request Error: {e}")
        return {'statusCode': 502, 'body': json.dumps(f"Network Error: {str(e)}")}
    except Exception as e:
        logger.error(f"General Execution Error: {e}", exc_info=True)
        return {'statusCode': 500, 'body': json.dumps(f"Execution failed: {str(e)}")}