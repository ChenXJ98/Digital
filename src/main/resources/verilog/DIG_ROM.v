<?
    romMaxSize := 1 << elem.AddrBits;
    romSize := sizeOf(elem.Data);
    moduleName = format("%s_%dX%d", moduleName, romMaxSize, elem.Bits);
    dBitRange := format("[%d:0]", elem.Bits - 1);
    aBitRange := format("[%d:0]", elem.AddrBits - 1);

?>module <?= moduleName ?> (
    input <?= aBitRange ?> A,
    input sel,
    output reg <?= dBitRange ?> D
);
    reg <?= dBitRange ?> my_rom [0:<?= (romSize - 1) ?>];

    always @ (*) begin
        if (~sel)
            D = <?= elem.Bits ?>'hz;<?
        if (romSize < romMaxSize) {
            lastAddr := format("%d'h%x", elem.AddrBits, romSize - 1); ?>
        else if (A > <?= lastAddr ?>)
            D = <?= elem.Bits ?>'h0;<?
        } ?>
        else
            D = my_rom[A];
    end

    initial begin<?

    for (i := 0; i < romSize; i++) { ?>
        my_rom[<?= i ?>] = <?= format("%d'h%x", elem.Bits, elem.Data[i]) ?>;<?
    } ?>
    end
endmodule
