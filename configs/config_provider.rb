require "json"

class ConfigProvider
  def initialize(package_name)
    path = File.join(File.dirname(__FILE__), "#{package_name}.json")
    body = File.read(path)
    @config = JSON.parse(body)
  end

  def github_url
    @config["inputs"]["github_url"]
  end

  def version
    @config["inputs"]["version"]
  end

  def mac
    @config["outputs"]["Darwin"]
  end

  def linux
    @config["outputs"]["Linux"]
  end
end
