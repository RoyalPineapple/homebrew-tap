class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "0.2.32"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.32/buttonheist-0.2.32-macos.tar.gz"
  sha256 "63eedd1be04823e8a393a1b70c539cda68ee2cec2ecf68cc117487364b9afedb"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v0.2.32/buttonheist-mcp-0.2.32-macos.tar.gz"
    sha256 "f098448b87970e3adf65bcd170c195c986190b54d84ddf496a73782661ddbc8a"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
    bin.install "ButtonHeistFrameworks" if (buildpath/"ButtonHeistFrameworks").exist?
    resource("mcp").stage { bin.install "buttonheist-mcp" }
  end

  def caveats
    <<~EOS
      MCP server is installed at:
        #{opt_bin}/buttonheist-mcp

      Add to your project's .mcp.json:
        {
"mcpServers": {
  "buttonheist": {
    "command": "#{opt_bin}/buttonheist-mcp",
    "args": []
  }
}
        }
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/buttonheist --version")
  end
end
