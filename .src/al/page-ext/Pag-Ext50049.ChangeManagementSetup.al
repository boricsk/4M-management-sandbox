pageextension 50049 "Change Management Setup" extends "Manufacturing Setup"
{
    layout
    {
        addlast(Numbering)
        {
            group("4M Change setup")
            {
                field("Change management nos"; Rec."Change management nos") { ApplicationArea = All; TableRelation = "No. Series"; }
                field("IATF Document number"; Rec."IATF Document number") { ApplicationArea = All; }
                field("Backup path"; Rec."Backup path") { ApplicationArea = All; }
            }
        }


    }
}
