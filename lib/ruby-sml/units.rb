# encoding: UTF-8

module SML
  Units = []

  Units[1] = { "id" => :year, "unit" => "a", "quantity" => "Time", "name" => "Year" }
  Units[2] = { "id" => :month, "unit" => "mo", "quantity" => "Time", "name" => "Month" }
  Units[3] = { "id" => :week, "unit" => "wk", "quantity" => "Time", "name" => "Week" }
  Units[4] = { "id" => :day, "unit" => "d", "quantity" => "Time", "name" => "Day" }
  Units[5] = { "id" => :hour, "unit" => "h", "quantity" => "Time", "name" => "Hour" }

  Units[6] = { "id" => :minute, "unit" => "min.", "quantity" => "Time", "name" => "Minute" }
  Units[7] = { "id" => :second, "unit" => "s", "quantity" => "Time", "name" => "Second" }
  Units[8] = { "id" => :degree, "unit" => "°", "quantity" => "Angle", "name" => "Degree" }
  Units[9] = { "id" => :celsius, "unit" => "°C", "quantity" => "Temperature", "name" => "Degree Celsius" }
  Units[10] = { "id" => :currency, "unit" => "currency", "quantity" => "(local) Currency", "name" => "" }

  Units[11] = { "id" => :metre, "unit" => "m", "quantity" => "Length", "name" => "Metre" }
  Units[12] = { "id" => :metre_second, "unit" => "m/s", "quantity" => "Speed", "name" => "Metre per Second" }
  Units[13] = { "id" => :cubicmetre, "unit" => "m³", "quantity" => "Volume", "name" => "Cubic Metre" }
  Units[14] = { "id" => :cubicmetre_c, "unit" => "m³", "quantity" => "Corrected Volume", "name" => "Cubic Metre" }
  Units[15] = { "id" => :cubicmetre_hour, "unit" => "m³/h", "quantity" => "Volume Flux", "name" => "Cubic Metre per Hour" }

  Units[16] = { "id" => :cubicmetre_hour_c, "unit" => "m³/h", "quantity" => "Corrected Volume Flux", "name" => "Cubic Metre per Hour" }
  Units[17] = { "id" => :cubicmetre_day, "unit" => "m³/d", "quantity" => "Volume Flux", "name" => "Cubic Metre per Day" }
  Units[18] = { "id" => :cubicmetre_day_c, "unit" => "m³/d", "quantity" => "Corrected Volume Flux", "name" => "Cubic Metre per Day" }
  Units[19] = { "id" => :litre, "unit" => "l", "quantity" => "Volume", "name" => "Litre" }
  Units[20] = { "id" => :kilogram, "unit" => "kg", "quantity" => "Mass", "name" => "Kilogram" }

  Units[21] = { "id" => :newton, "unit" => "N", "quantity" => "Force", "name" => "Newton" }
  Units[22] = { "id" => :newtonmeter, "unit" => "Nm", "quantity" => "Energy", "name" => "Newtonmeter" }
  Units[23] = { "id" => :pascal, "unit" => "Pa", "quantity" => "Pressure", "name" => "Pascal" }
  Units[24] = { "id" => :bar, "unit" => "bar", "quantity" => "Pressure", "name" => "Bar" }
  Units[25] = { "id" => :joule, "unit" => "J", "quantity" => "Energe", "name" => "Joule" }

  Units[26] = { "id" => :joule_hour, "unit" => "J/h", "quantity" => "Thermal Power", "name" => "Joule per Hour" }
  Units[27] = { "id" => :watt, "unit" => "W", "quantity" => "Active Power", "name" => "Watt" }
  Units[28] = { "id" => :voltampere, "unit" => "VA", "quantity" => "Apparent Power", "name" => "Volt-Ampere" }
  Units[29] = { "id" => :var, "unit" => "var", "quantity" => "Reactive Power", "name" => "var" }
  Units[30] = { "id" => :watthour, "unit" => "Wh", "quantity" => "Active Energy", "name" => "Watt-Hour" }

  Units[31] = { "id" => :voltamperehour, "unit" => "VAh", "quantity" => "Apparent Energy", "name" => "Volt-Ampere-Hour" }
  Units[32] = { "id" => :varhour, "unit" => "varh", "quantity" => "Reactive Energy", "name" => "Var-Hour" }
  Units[33] = { "id" => :ampere, "unit" => "A", "quantity" => "Current", "name" => "Ampere" }
  Units[34] = { "id" => :coulomb, "unit" => "C", "quantity" => "Electrical Charge", "name" => "Coulomb" }
  Units[35] = { "id" => :volt, "unit" => "V", "quantity" => "Voltage", "name" => "Volt" }

  Units[36] = { "id" => :volt_metre, "unit" => "V/m", "quantity" => "Eletric Field Strength", "name" => "Volt per Metre" }
  Units[37] = { "id" => :farad, "unit" => "F", "quantity" => "Capacitance", "name" => "Farad" }
  Units[38] = { "id" => :ohm, "unit" => "Ω", "quantity" => "Resistance", "name" => "Ohm" }
  Units[39] = { "id" => :ohm_metre, "unit" => "Ωm²/m", "quantity" => "Resistivity", "name" => "Ohm-Metre" }
  Units[40] = { "id" => :weber, "unit" => "Wb", "quantity" => "Magnetic Flux", "name" => "Weber" }

  Units[41] = { "id" => :tesla, "unit" => "T", "quantity" => "Magnetic Flux Density", "name" => "Tesla" }
  Units[42] = { "id" => :ampere_metre, "unit" => "A/m", "quantity" => "Magnetic Field Strength", "name" => "Ampere per Metre" }
  Units[43] = { "id" => :henry, "unit" => "H", "quantity" => "Inductance", "name" => "Henry" }
  Units[44] = { "id" => :hertz, "unit" => "Hz", "quantity" => "Frequency", "name" => "Hertz" }
  Units[45] = { "id" => :one_watthour, "unit" => "1/(Wh)", "quantity" => "R_W, Active Energy Meter Constant or Pulse Value", "name" => "" }

  Units[46] = { "id" => :one_varhour, "unit" => "1/(varh)", "quantity" => "R_B, Reactive Energy Meter Constant or Pulse Value", "name" => "" }
  Units[47] = { "id" => :one_voltamperehour, "unit" => "1/(VAh)", "quantity" => "R_S, Apparent Energy Meter Constant or Pulse Value", "name" => "" }
  Units[48] = { "id" => :voltsquaredhours, "unit" => "V²h", "quantity" => "Volt-squared Hour", "name" => "Volt-Squared-Hours" }
  Units[49] = { "id" => :amperesquaredhours, "unit" => "A²h", "quantity" => "Ampere-squared hour", "name" => "Ampere-Squared-Hours" }
  Units[50] = { "id" => :kilogram_second, "unit" => "kg/s", "quantity" => "Mass Flux", "name" => "Kilogram per Second" }

  Units[51] = { "id" => :siemens, "unit" => "S", "quantity" => "Conductance", "name" => "Siemens" }
  Units[52] = { "id" => :kelvin, "unit" => "K", "quantity" => "Temperature", "name" => "Kelvin" }
  Units[53] = { "id" => :one_voltsquaredhour, "unit" => "1/(V²h)", "quantity" => "R_U2h, Volt-Squared Hour Meter Constant or Pulse Value", "name" => "" }
  Units[54] = { "id" => :one_amperesquaredhour, "unit" => "1/(A²h)", "quantity" => "R_I2h, Ampere-Squared Hour Meter Constant or Pulse Value", "name" => "" }
  Units[55] = { "id" => :one_cubicmetre, "unit" => "1/m³", "quantity" => "R_V, Meter Constant or Pulse Value (Volume)", "name" => "" }

  Units[56] = { "id" => :percent, "unit" => "%", "quantity" => "Percentage", "name" => "Percent" }
  Units[57] = { "id" => :amperehour, "unit" => "Ah", "quantity" => "Ampere-Hours", "name" => "Ampere-Hour" }
  Units[60] = { "id" => :watthour_cubicmetre, "unit" => "Wh/m³", "quantity" => "Energy per Volume", "name" => "Watthour per Cubic Metre" }

  Units[61] = { "id" => :joule_cubicmetre, "unit" => "J/m³", "quantity" => "Calorific Value, Wobbe", "name" => "Joule per Cubic Metre" }
  Units[62] = { "id" => :molpercent, "unit" => "Mol %", "quantity" => "Molar Fraction of Gas Composition", "name" => "Mole Percent" }
  Units[63] = { "id" => :gram_cubicmetre, "unit" => "g/m³", "quantity" => "Mass Density", "name" => "Gram per Cubic Metre" }
  Units[64] = { "id" => :pascalsecond, "unit" => "Pa s", "quantity" => "Dynamic Viscosity", "name" => "Pascal Second" }

  Units[254] = { "id" => :other, "unit" => "other", "quantity" => "Other Unit", "name" => "" }
  Units[255] = { "id" => :count, "unit" => "count", "quantity" => "Count, unitless", "name" => "" }

end
