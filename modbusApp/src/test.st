program test

int volts;
assign volts to "{PORT}:outVolts";

int amps;
assign amps to "{PORT}:outAmpsMax";
monitor amps;

int delta = 10;

ss generate_voltage {
    state init {
        when () {
            volts = 10;
            pvPut(volts);
        } state ramp
    }

    state ramp {
        when (delay(1)) {
            if (volts > 0 && volts < 1000) {
                if (amps < 80) {
                    volts += delta;
                } else {
                    volts -= delta;
                }
            }
            pvPut(volts);
        } state ramp
    }
}
