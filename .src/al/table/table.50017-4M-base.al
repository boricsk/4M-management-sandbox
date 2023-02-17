table 50017 "SEI 4M change request"
{
    Caption = '4M change request';
    DataClassification = ToBeClassified;

    fields
    {
        field(010; "Serial Number"; Code[20])
        {
            trigger OnValidate()
            begin
                if "Serial Number" <> xRec."Serial Number" then begin
                    ManSetup.Get();
                    NoSeriesMgmnt.TestManual(ManSetup."Simulated Order Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(011; "Status"; Option) { OptionMembers = Prepare,Active,Closed; InitValue = Prepare; }
        field(015; "Version"; Integer) { }
        field(020; "Area"; Option) { OptionMembers = FFC,Medical; }
        field(030; "Request by"; Code[50]) { }
        field(040; "Request date"; Date) { }
        field(050; "Item number"; Code[20]) { TableRelation = Item."No."; }
        field(060; "Item description"; Text[250]) { }
        field(065; "Man / Machine description"; Text[250]) { }
        field(070; "Type of 4M request"; Option) { OptionMembers = Temporary,Permanent; }
        field(080; "Scope of 4M request"; Option) { OptionMembers = Material,Method,Man,Machine; }
        field(090; "Work order numner"; Code[50]) { }
        field(100; "Duration of 4M"; Date) { }
        field(110; "Current regulation"; Blob) { }
        field(120; "Prupose of change with reason"; Blob) { }
        field(130; "Attachment"; Blob) { }
        field(140; "Customer name"; Text[100]) { }
        field(145; "Customer item"; Code[50]) { }
        field(150; "Special work instruction"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(160; "Production release"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(165; "Customer notify"; Boolean) { InitValue = false; }
        field(166; "Work instruction details"; Blob) { }
        field(170; "APQP"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(180; "Evaluation required"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(190; "Waiver"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(195; "Waiver number"; Code[20]) { }
        field(200; "PCN"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(205; "PCN number"; Code[20]) { }
        field(210; "Test production"; Option) { OptionMembers = Yes,No; InitValue = No; }
        field(220; "Test production quantity"; Integer) { }
        field(230; "Cost of change"; Integer) { }
        field(240; "DE approved"; Code[50]) { }
        field(250; "PE approved"; Code[50]) { }
        field(260; "ENG leader approved"; Code[50]) { }
        field(270; "PP approved"; Code[50]) { }
        field(280; "Prod. manager approved"; Code[50]) { }
        field(290; "QA engineer approved"; Code[50]) { }
        field(300; "Final decision"; Code[50]) { }
        field(310; "Approve-decline comments"; Blob) { }
        field(320; "No. Series"; Code[20])
        {
            Caption = 'No. Serise';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(330; "Cost estimation"; Decimal) { }
        field(335; "Unit of cost est."; Text[10]) { TableRelation = "Unit of Measure"; }








    }

    keys
    {
        key(PK; "Serial Number", "Version") { Clustered = true; }
        //key(PK2; "Duration of 4M", "Customer name") { }
    }

    var
        myInt: Integer;
        NoSeriesMgmnt: Codeunit NoSeriesManagement;
        ManSetup: Record "Manufacturing Setup";

    trigger OnInsert()
    begin
        if "Serial Number" = '' then begin

            ManSetup.Get();
            ManSetup.TestField("Simulated Order Nos.");
            NoSeriesMgmnt.InitSeries(ManSetup."Simulated Order Nos.", xRec."No. Series", 0D, "Serial Number", "No. Series");
        end;
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}