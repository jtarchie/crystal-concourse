require "yaml"
require "pretty_print"

class ResourceType
  YAML.mapping(
    name: String,
    type: String,
    source: YAML::Any,
    privileged: {
      type: Bool,
      default: false,
    },
    tags: {
      type: Array(String),
      default: [] of String,
    },
  )
end

class Resource
  YAML.mapping(
    name: String,
    type: String,
    source: YAML::Any,
    check_every: {
      type: String,
      default: "1m",
    },
    tags: {
      type: Array(String),
      default: [] of String,
    },
    webhook_token: String?,
  )
end

class Group
  YAML.mapping(
    name: String,
    jobs: {
      type: Array(String)?,
      default: [] of String,
    },
    resources: {
      type: Array(String)?,
      default: [] of String,
    },
  )
end

class Task
  YAML.mapping(
    task: String,
  )
end

class Get
  YAML.mapping(
    get: String,
    resource: String?,
    version: String?,
    passed: {
      type: Array(String),
      default: [] of String,
    },
    params: YAML::Any?,
    trigger: {
      type: Bool?,
      default: false,
    }
  )
end

class Put
  YAML.mapping(
    put: String,
    resource: String?,
    params: YAML::Any?,
    get_params: YAML::Any?,
  )
end

alias Step = Task | Get | Put

class Job
  YAML.mapping(
    name: String,
    serial: {
      type: Bool?,
      default: false,
    },
    build_logs_to_retain: Int::Unsigned?,
    serial_groups: {
      type: Array(String)?,
      default: [] of String,
    },
    max_in_flight: Int::Unsigned?,
    public: {
      type: Bool?,
      default: false,
    },
    disable_manual_trigger: {
      type: Bool?,
      default: false,
    },
    interruptible: {
      type: Bool?,
      default: false,
    },
    on_success: Step?,
    on_failure: Step?,
    ensure: Step?,
    plan: {
      type: Array(Step)?,
      default: [] of Step,
    },
  )
end

class Pipeline
  YAML.mapping(
    resource_types: {
      type: Array(ResourceType)?,
      default: [] of ResourceType,
    },
    resources: {
      type: Array(Resource)?,
      default: [] of Resource,
    },
    jobs: {
      type: Array(Job)?,
      default: [] of Job,
    },
    groups: {
      type: Array(Group)?,
      default: [] of Group,
    },
  )
end

contents = File.read ARGV[0]
contents = contents.gsub(/\{\{(?<name>.+)\}\}/, "\"{{\\k<name>}}\"")
puts Pipeline.from_yaml(contents).to_yaml
