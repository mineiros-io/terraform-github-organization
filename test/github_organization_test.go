package test

import (
	"fmt"
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

var githubOrganization, githubToken string

func init() {
	githubOrganization = os.Getenv("GITHUB_ORGANIZATION")
	githubToken = os.Getenv("GITHUB_TOKEN")

	if githubOrganization == "" {
		panic("Please set a github organization using the GITHUB_ORGANIZATION environment variable.")
	}

	if githubToken == "" {
		panic("Please set a github token using the GITHUB_TOKEN environment variable.")
	}
}

func TestGithubOrganization(t *testing.T) {
	t.Parallel()

	expectedProjects := []interface{}{
		map[string]interface{}{
			"name": fmt.Sprintf("test-project-%s", random.UniqueId()),
			"body": "This is a test project created by Terraform",
		},
		map[string]interface{}{
			"name": fmt.Sprintf("test-project-%s", random.UniqueId()),
		},
	}

	expectedBlockedUsers := []string{
		"Testuser1",
		"Testuser2",
	}

	expectedAdmins := []string{
		"terraform-test-admin",
	}

	expectedMembers := []string{
		"terraform-test-user-1",
		"terraform-test-user-2",
	}

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "../examples/organization",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"blocked_users": expectedBlockedUsers,
			"admins":        expectedAdmins,
			"members":       expectedMembers,
			"projects":      expectedProjects,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

}
