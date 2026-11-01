# Project

The starting point for a 0verwatch community project. Create your own private repository from this template. Replace this README with your own once
your project has a shape.

## What is here

| Path | What it does |
|---|---|
| `.github/workflows/ci.yml` | Runs on every pull request and every push to `main`: a secret scan of the whole history (gitleaks), a Terraform format check, and placeholders for your linter and tests |
| `.github/workflows/deploy.yml` | Deploys from `main` into your AWS account, signing in with GitHub's OIDC token. It is skipped until `DEPLOY_ROLE_ARN` is set |
| `bootstrap/` | Terraform you apply once from your laptop. It creates the state bucket for your other Terraform and the role the deploy workflow uses |
| `.devcontainer/` | An optional development container with Python 3.12, Node 22, Terraform, the AWS CLI and Docker |

## First steps

1. Sign in: `aws sso login --profile project`.
2. Create the state bucket and the deploy role:
   ```sh
   cd bootstrap
   terraform init
   AWS_PROFILE=project terraform apply -var github_repository=<your GitHub username>/<this repository>
   ```
   This root keeps its state on your laptop, in `bootstrap/terraform.tfstate`. Git ignores it,
   so keep a copy somewhere safe.
3. In the repository's settings, under Secrets and variables → Actions → Variables, set
   `DEPLOY_ROLE_ARN` to the `deploy_role_arn` output.
4. Push a branch, open a pull request, and watch CI run. When you merge to `main`, the deploy
   workflow runs. A run from any other branch is refused at sign-in.

## Configuration

Keep anything that differs between environments in configuration, never in code:

| Setting | Where it lives |
|---|---|
| `MODEL_BASE_URL`, `MODEL_ID` | Environment variables of your service |
| The model role's ARN | The repository variable `MODEL_ROLE_ARN`. Your tech lead gives you the value |
| Anything secret | A secret store in your account, never in the repository |

## Rules

- No secrets in the repository, ever. The secret scan fails the build if it finds one.
- Synthetic data only.
- Licence-clear dependencies, and a current list of them.
- Branches and pull requests, squash merges, no force-push. In Settings → Branches, turn on whatever protection your plan offers for `main`. If it offers none, keep to the rule yourself: a push to `main` deploys to your AWS account.
- Anyone you add as a collaborator can push to `main`, so anyone you add can deploy.
