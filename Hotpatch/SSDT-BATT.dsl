

DefinitionBlock("", "SSDT", 2, "hack", "BATT", 0)
{
    External(_SB.PCI0.LPCB, DeviceObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.ECAV, MethodObj)
    External(BSLF, IntObj)
    External(_SB.PCI0.LPCB.EC.RDBL, IntObj)
    External(_SB.PCI0.LPCB.EC.RDWD, IntObj)
    External(_SB.PCI0.LPCB.EC.RDBT, IntObj)
    External(_SB.PCI0.LPCB.EC.RCBT, IntObj)
    External(_SB.PCI0.LPCB.EC.RDQK, IntObj)
    External(_SB.PCI0.LPCB.EC.MUEC, MutexObj)
    External(_SB.PCI0.LPCB.EC.SBBY, IntObj)
    External(_SB.PCI0.LPCB.EC.SWTC, MethodObj)
    External(_SB.PCI0.LPCB.EC.DAT0, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.WRBL, IntObj)
    External(_SB.PCI0.LPCB.EC.WRWD, IntObj)
    External(_SB.PCI0.LPCB.EC.WRBT, IntObj)
    External(_SB.PCI0.LPCB.EC.SDBT, IntObj)
    External(_SB.PCI0.LPCB.EC.WRQK, IntObj)
    External(_SB.PCI0.LPCB.EC.DAT1, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.DA20, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.DA21, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.RRAM, MethodObj)
    External(_SB.PCI0.LPCB.EC.DECF, IntObj)
    
    Device(_SB.PCI0.MCHC) { Name(_ADR, 0x00000000) }    
    
    // This is an override for battery methods that access EC fields
    // larger than 8-bit.
    Scope (_SB.PCI0.LPCB.EC)
    {
        OperationRegion (ECOR, EmbeddedControl, 0x00, 0xFF)
                Offset (0x93),
                TH00,8,TH01,8,
                TH10,8,TH11,8,
                Offset (0xBE),
                /*B0TM*/,   16,
                /*B0C1*/,   16,
                /*B0C2*/,   16,
                XC30,8,XC31,8,
                Offset (0xDE),
                /*B1TM*/,   16,
                /*B1C1*/,   16,
                /*B1C2*/,   16,
                YC30,8,YC31,8,
                Offset (0xF4),
                B0S0,8,B0S1,8,
                Offset (0xFC),
                B1S0,8,B1S1,8
        }
            PRTC,   8, 
            PRT2,   8, 
            
        Field (SMBX, ByteAcc, NoLock, Preserve)
            Offset (0x04), 
    }                            
    //patched methods
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (BIFA, 0, NotSerialized)

        Method (SMBR, 3, Serialized)
        
        Method (SMBW, 5, Serialized)
        
        Method (ECSB, 7, NotSerialized)
        
        Method (TACH, 1, NotSerialized)
    }    
    
    Method (B1B2, 2, NotSerialized) { Return (Or (Arg0, ShiftLeft (Arg1, 8))) }
    
    // added methods (group 2)
    Scope (_SB.PCI0.LPCB)
    {
        Scope (EC)
        {
            Method (RDBA, 0, Serialized)
            Method (WRBA, 1, Serialized)
        }
    }
}
//EOF