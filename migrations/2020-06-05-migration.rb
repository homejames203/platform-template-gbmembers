# Action options must be passed as a JSON string
#
# Format with example values:
#
# {
#   "core" => {
#     "api" => "https://foo.web-server/app/api/v1",
#     "agent_api" => "https://foo.web-server/app/components/agent/app/api/v1",
#     "proxy_url" => "https://foo.web-server/app/components",
#     "server" => "https://web-server",
#     "space_slug" => "foo",
#     "space_name" => "Foo",
#     "service_user_username" => "service_user_username",
#     "service_user_password" => "secret",
#     "task_api_v1" => "https://foo.web-server/app/components/task/app/api/v1",
#     "task_api_v2" => "https://foo.web-server/app/components/task/app/api/v2"
#   },
#   "http_options" => {
#     "log_level" => "info",
#     "log_output" => "stderr"
#   }
# }

require "kinetic_sdk"
require "json"

# determine the directory paths
pwd = File.dirname(File.expand_path(__FILE__))
core_path = File.join(pwd, "../core")
task_path = File.join(pwd, "../task")

space_sdk = KineticSdk::Core.new({
    space_server_url: vars["core"]["server"],
    space_slug: vars["core"]["space_slug"],
    username: vars["core"]["service_user_username"],
    password: vars["core"]["service_user_password"],
    options: http_options.merge({ export_directory: "#{core_path}" }),
  })

### TEST STEP 1 -- Add my new form

# Build up path to the form definition
form_location = File.join(core_path, "/space/datastore/my-new-form-slug.json")
# Parse the form definition
form_def = JSON.parse(File.read(form_location))
# Import the form
space_sdk.add_datastore_form(form_def)
# OR IF IT WAS AN UPDATE space_sdk.update_datastore_form('whatever-form-slug', form_def)

