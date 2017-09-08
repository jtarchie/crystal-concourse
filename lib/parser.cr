require "pipeline"

class Parser
  def self.from_file(filename : String) : Pipeline
    Pipeline.from_yaml(YAML.dump(YAML.parse(File.read(filename))))
  end
end
