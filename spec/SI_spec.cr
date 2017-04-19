require "./spec_helper"

describe SI do
  it "formats numbers" do
    SI.format(1.21e9, "W").should eq("1.21 GW")
    SI.format(1.21e9, "W", separator: "").should eq("1.21GW")
    SI.format(1337, "B").should eq("1.337 kB")
    SI.format(-1.21e9, "W").should eq("-1.21 GW")
    SI.format(1, "W").should eq("1 W")
    SI.format(0, "W").should eq("0 W")
    SI.format(999, "W").should eq("999 W")
    SI.format(1000, "W").should eq("1 kW")
    SI.format(1001, "W").should eq("1.001 kW")
    SI.format(22e-6, "F").should eq("22 µF")
    SI.format(22e-9, "F").should eq("22 nF")
    SI.format(22e-12, "F").should eq("22 pF")
  end

  it "parses numbers" do
    SI.parse("1.21 GW").should eq({1.21e9, "W"})
    SI.parse("1.21GW").should eq({1.21e9, "W"})
    SI.parse("1.337 kB").should eq({1337.0, "B"})
    SI.parse("-1.21 GW").should eq({-1.21e9, "W"})
    SI.parse("1 W").should eq({1, "W"})
    SI.parse("0 W").should eq({0, "W"})
    SI.parse("22 µF").should eq({22e-6, "F"})
    SI.parse("22 uF").should eq({22e-6, "F"})

    if parsed = SI.parse("22 nF")
      parsed[0].should be_close(22e-9, 0.001)
      parsed[1].should eq("F")
    end
    if parsed = SI.parse("22 nF")
      parsed[0].should be_close(22e-12, 0.001)
      parsed[1].should eq("F")
    end
  end

  it "returns nil on parse failure" do
    SI.parse("").should eq(nil)
  end
end
