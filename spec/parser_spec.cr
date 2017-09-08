require "spec"
require "../lib/parser"

describe Parser do
  it "returns a pipeline" do
    filename = File.join(__DIR__, "fixtures", "pipeline.yml")
    pipeline = Parser.from_file(filename)
    pipeline.to_yaml.should eq YAML.dump(YAML.parse(File.read(filename)))
  end
end
