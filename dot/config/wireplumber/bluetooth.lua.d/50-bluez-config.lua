bluez_monitor.properties = {
  ["bluez5.roles"] = "[ a2dp_sink a2dp_source hfp_hf hfp_ag hsp_hs hsp_ag ]",
  ["bluez5.hfphsp-backend"] = "native",
}

bluez_monitor.rules = {
  {
    matches = {
      {
        { "device.name", "matches", "bluez_card.*" },
      },
    },
    apply_properties = {
      ["bluez5.auto-connect"] = "[ hfp_hf hsp_hs a2dp_sink ]",
    },
  },
}
