# Release Process

We use [Semantic Versioning](https://semver.org/) (vX.Y.Z) for our infrastructure releases. This ensures we know exactly what kind of changes are included in each release.

## 1. Determine the New Version Number

Check the current version (e.g., `v1.0.0`) and decide how to increment it based on your changes:

| Change Type | Example (from v1.0.0) | When to use?                                                                                               |
| :---------- | :-------------------- | :--------------------------------------------------------------------------------------------------------- |
| **Patch**   | `v1.0.1`              | Bug fixes, typos, small changes. **Safe to update.**                                                       |
| **Minor**   | `v1.1.0`              | New resources, new features **Backward compatible.**                                                       |
| **Major**   | `v2.0.0`              | Deleting resources, changing state structure, or big architectural changes. **May break existing setups.** |

---

## 2. Create and Push the Tag

Once you have merged your Pull Request into `main`, pull the latest changes and create the tag.

1. Update your local main branch:
   ```bash
   git checkout main
   git pull origin main
   ```
2. Create the tag: Replace v1.0.0 with your determined version number:

   ```bash
   # git tag -a <tag_name> -m "<description>"
   git tag -a v1.0.1 -m "Fix typos"

   ```

3. Push the tag to GitHub: This triggers the Release Workflow automatically:
   ```bash
   git push origin v1.0.1
   ```
