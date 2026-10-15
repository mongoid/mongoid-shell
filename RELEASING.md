# Releasing Mongoid::Shell

## Prepare

Use the upstream checkout on clean `master`, verify `origin` is `mongoid/mongoid-shell`, and run `git pull --ff-only`. Check supported platforms in [GitHub Actions](https://github.com/mongoid/mongoid-shell/actions). Follow semantic versioning: patch for fixes, minor for backward-compatible features, major for breaking changes.

Set `lib/mongoid/shell/version.rb` to the release version, date its `CHANGELOG.md` section using `YYYY/MM/DD`, and remove the contribution placeholder.

```sh
bundle install
bundle exec rake
git add CHANGELOG.md lib/mongoid/shell/version.rb RELEASING.md
git commit -m "Preparing for release, 0.5.1."
git push origin master
```

## Publish RubyGems and GitHub

```sh
bundle exec rake release
```

The task builds the gem, pushes its tag, and publishes to RubyGems. Complete MFA when prompted. If interrupted, inspect the tag and RubyGems version before retrying; never move a published tag. If only publication is missing, resume with `gem push pkg/mongoid-shell-0.5.1.gem`.

A tag is not a GitHub release. After confirming RubyGems publication, create the matching GitHub release with changelog notes:

```sh
version=0.5.1
notes="$(mktemp)"
awk -v version="$version" '
  /^### / {
    if (found) exit
    if ($2 == version) found = 1
    next
  }
  found { print }
' CHANGELOG.md > "$notes"
gh release create "v$version" --repo mongoid/mongoid-shell --verify-tag --title "$version" --notes-file "$notes" --latest
rm "$notes"
curl --fail --silent --show-error "https://rubygems.org/api/v2/rubygems/mongoid-shell/versions/$version.json"
gh release view "v$version" --repo mongoid/mongoid-shell
```

Verify both the published gem and non-draft GitHub release before declaring completion.

## Prepare the Next Version

Increment the development patch version in `lib/mongoid/shell/version.rb` (for example, `0.5.2`). Add `### 0.5.2 (Next)` with a contribution placeholder above the released changelog section. Commit and push those changes to `master`, leaving the released tag unchanged.
