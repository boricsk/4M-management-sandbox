tableextension 50050 "User Setup" extends "User Setup"
{
    fields
    {
        field(50000; "4M Proc. Engineering approve"; Boolean) { }
        field(50001; "4M Design Engineering approve"; Boolean) { }
        field(50002; "4M Lead Engineer approve"; Boolean) { }
        field(50010; "4M QA Engineer approve"; Boolean) { }
        field(50015; "4M Production approve"; Boolean) { }
        field(50020; "4M Planner approve"; Boolean) { }
        field(50025; "4M QA Manager approve"; Boolean) { }
        field(50030; "4M Administrator"; Boolean) { InitValue = false; }
        field(50040; "4M Notify Email"; Text[100]) { }
        field(50050; "4M Scope"; Option) { OptionMembers = none,MDH,FFC,Both; }

    }
}
