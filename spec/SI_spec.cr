require "./spec_helper"

describe SI do
  it "formats numbers" do
    SI.format(1.21e9, "W").should eq("1.21 GW")
    SI.format(1.21e9, "W", separator: "").should eq("1.21GW")
    SI.format(1337, "B").should eq("1.337 kB")
    SI.format(-1.21e9, "W").should eq("-1.21 GW")
    SI.format(1, "W").should eq("1 W")
    SI.format(0, "W").should eq("0 W")
  end

  it "parses numbers" do
    SI.parse("1.21 GW").should eq({1.21e9, "W"})
    SI.parse("1.21GW").should eq({1.21e9, "W"})
    SI.parse("1.337 kB").should eq({1337.0, "B"})
    SI.parse("-1.21 GW").should eq({-1.21e9, "W"})
    SI.parse("1 W").should eq({1, "W"})
    SI.parse("0 W").should eq({0, "W"})
  end

  it "returns nil on parse failure" do
    SI.parse("").should eq(nil)
  end
end
