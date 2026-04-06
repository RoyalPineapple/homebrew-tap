class Buttonheist < Formula
  desc "Give AI agents full programmatic control of iOS apps"
  homepage "https://github.com/RoyalPineapple/TheButtonHeist"
  version "2026.04.06"

  url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06/buttonheist-2026.04.06-macos.tar.gz"
  sha256 "25b7ec3324ac859abc7ac9667a93525109b3eccd13b0f7ee8a13d675beb8ca65"

  resource "mcp" do
    url "https://github.com/RoyalPineapple/TheButtonHeist/releases/download/v2026.04.06/buttonheist-mcp-2026.04.06-macos.tar.gz"
    sha256 "3ed2a483680b06d4cd17f06d191aede2832248c4b4b8e599ddb8a464f4daa9d6"
  end

  depends_on :macos
  depends_on macos: :sonoma

  def install
    bin.install "buttonheist"
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
