require "yaml"

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

alias Version = String | Hash(String, String)

class ImageResource
  YAML.mapping(
    type: String,
    source: YAML::Any,
    params: Hash(String, String)?,
    version: Version,
  )
end

class Input
  YAML.mapping(
    name: String,
    path: String?
  )
end

class Output
  YAML.mapping(
    name: String,
    path: String?
  )
end

class Cache
  YAML.mapping(
    path: String
  )
end

class Run
  YAML.mapping(
    path: String,
    args: {
      type: Array(String)?,
      default: [] of String,
    },
    dir: String?,
    user: String?
  )
end

class TaskConfig
  YAML.mapping(
    platform: String,
    image_resource: ImageResource?,
    rootfs_uri: String?,
    inputs: {
      type: Array(Input)?,
      default: [] of Input,
    },
    outputs: {
      type: Array(Output)?,
      default: [] of Output,
    },
    caches: {
      type: Array(Cache)?,
      default: [] of Cache,
    },
    run: Run,
    params: Hash(String, String)?,
  )
end

class Task
  YAML.mapping(
    task: String,
    config: TaskConfig,
    privileged: {
      type: Bool?,
      default: false
    },
    params: Hash(String, String)?,
    image: String?,
    input_mapping: Hash(String, String)?,
    output_mapping: Hash(String, String)?,
    on_failure: Step?,
    on_success: Step?,
    ensure: Step?,
    try: Step?,
    timeout: String?,
    attempts: Int::Unsigned?,
    tags: {
      type: Array(String),
      default: [] of String,
    },
  )
end

alias Params = Hash(String, YAML::Any)

class Get
  YAML.mapping(
    get: String,
    resource: String?,
    version: Version?,
    passed: {
      type: Array(String),
      default: [] of String,
    },
    params: Params?,
    trigger: {
      type: Bool?,
      default: false,
    },
    on_failure: Step?,
    on_success: Step?,
    ensure: Step?,
    try: Step?,
    timeout: String?,
    attempts: Int::Unsigned?,
    tags: {
      type: Array(String),
      default: [] of String,
    },
  )
end

class Put
  YAML.mapping(
    put: String,
    resource: String?,
    params: Params?,
    get_params: Params?,
    on_failure: Step?,
    on_success: Step?,
    ensure: Step?,
    try: Step?,
    timeout: String?,
    attempts: Int::Unsigned?,
    tags: {
      type: Array(String),
      default: [] of String,
    },
  )
end

class Aggregate
  YAML.mapping(
    aggregate: {
      type: Array(Step)?,
      default: [] of Step,
    },
    on_failure: Step?,
    on_success: Step?,
    ensure: Step?,
    try: Step?,
    timeout: String?,
    attempts: Int::Unsigned?,
    tags: {
      type: Array(String),
      default: [] of String,
    },
  )
end

class Do
  YAML.mapping(
    do: {
      type: Array(Step)?,
      default: [] of Step,
    },
    on_failure: Step?,
    on_success: Step?,
    ensure: Step?,
    try: Step?,
    timeout: String?,
    attempts: Int::Unsigned?,
    tags: {
      type: Array(String),
      default: [] of String,
    },
  )
end

alias Step = Do | Aggregate | Task | Get | Put

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
