pageextension 50050 "User Setup" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("QA Engineer approve"; Rec."4M QA Engineer approve") { ApplicationArea = All; }
            field("Design Engineering approve"; Rec."4M Design Engineering approve") { ApplicationArea = All; }
            field("Proc. Engineering approve"; Rec."4M Proc. Engineering approve") { ApplicationArea = All; }
            field("Lead Engineer approve"; Rec."4M Lead Engineer approve") { ApplicationArea = All; }
            field("Production approve"; Rec."4M Production approve") { ApplicationArea = All; }
            field("Planner approve"; Rec."4M Planner approve") { ApplicationArea = All; }
            field("QA Manager approve"; Rec."4M QA Manager approve") { ApplicationArea = All; }
            field(Administrator; Rec."4M Administrator") { ApplicationArea = All; }
            field("Notify Email"; Rec."4M Notify Email") { ApplicationArea = All; }
            field("Scope"; Rec."4M Scope") { ApplicationArea = All; }
        }
    }
}