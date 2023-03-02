page 50018 "Change management list"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SEI 4M change request";
    Caption = 'Change Management list';
    CardPageId = 50017;
    Editable = false;

    layout
    {

        area(Content)
        {
            repeater(Control1)
            {
                field("4M Number"; Rec."Serial Number") { ApplicationArea = All; Caption = 'Number of change request'; }
                field(Status; Rec.Status) { ApplicationArea = All; }
                field("Scope of 4M request"; Rec."Scope of 4M request") { ApplicationArea = All; }
                field(Version; Rec.Version) { ApplicationArea = All; }
                field("Area"; Rec."Area") { ApplicationArea = All; }
                field("Request by"; Rec."Request by") { ApplicationArea = All; }
                field("Request date"; Rec."Request date") { ApplicationArea = All; Editable = false; }
                field("Item number"; Rec."Item number") { TableRelation = Item."No."; ApplicationArea = All; }
                field("Item description"; Rec."Item description") { ApplicationArea = All; Editable = false; }
                field("Type of 4M request"; Rec."Type of 4M request") { ApplicationArea = All; }
                field("Work order number"; Rec."Work order numner") { ApplicationArea = All; Caption = 'Work order number'; }
                field("Duration of 4M"; Rec."Duration of 4M") { ApplicationArea = All; }
                field("Man / Machine description"; Rec."Man / Machine description") { ApplicationArea = All; }
                field("Machine center"; Rec."Machine center") { ApplicationArea = All; }
                field("Customer name"; Rec."Customer name") { TableRelation = Customer.Name; ApplicationArea = All; }
                field("Customer item"; Rec."Customer item") { ApplicationArea = All; }
                field("Special work instruction"; Rec."Special work instruction") { ApplicationArea = All; }
                field("Production release"; Rec."Production release") { ApplicationArea = All; }
                field(APQP; Rec.APQP) { ApplicationArea = All; }
                field("Customer notify"; Rec."Customer notify") { ApplicationArea = All; }
                field("Evaluation required"; Rec."Evaluation required") { ApplicationArea = All; }
                field("Test production quantity"; Rec."Test production quantity") { ApplicationArea = All; }
                field(Waiver; Rec.Waiver) { ApplicationArea = All; }
                field("Waiver number"; Rec."Waiver number") { ApplicationArea = All; }
                field(PCN; Rec.PCN) { ApplicationArea = All; }
                field("PCN number"; Rec."PCN number") { ApplicationArea = All; }
                field("Cost of change"; Rec."Cost estimation") { }
                field("Unit of cost estimation"; Rec."Unit of cost est.") { }

                field("DE approved"; Rec."DE approved") { ApplicationArea = All; }
                field("DE approved user"; Rec."DE approved user") { ApplicationArea = All; }
                field("DE approved date"; Rec."DE approved date") { ApplicationArea = All; }
                field("DE approve comments"; Rec."DE approve comments") { ApplicationArea = All; }

                field("PE approved"; Rec."PE approved") { ApplicationArea = All; }
                field("PE approved user"; Rec."PE approved user") { ApplicationArea = All; }
                field("PE approved date"; Rec."PE approved date") { ApplicationArea = All; }
                field("PE approve comments"; Rec."PE approve comments") { ApplicationArea = All; }

                field("ENG leader approved"; Rec."ENG leader approved") { ApplicationArea = All; }
                field("ENG leader user"; Rec."ENG leade user") { ApplicationArea = All; }
                field("ENG leader approved date"; Rec."ENG leader approved date") { ApplicationArea = All; }
                field("ENG approve comments"; Rec."ENG approve comments") { ApplicationArea = All; }

                field("Prod. manager approved"; Rec."Prod. manager approved") { ApplicationArea = All; }
                field("Prod. manager user"; Rec."Prod. manager user") { ApplicationArea = All; }
                field("Prod. manager approved date"; Rec."Prod. manager approved date") { ApplicationArea = All; }
                field("Prod. manager approve comments"; Rec."ProdMan approve comments") { ApplicationArea = All; }

                field("PP approved"; Rec."PP approved") { ApplicationArea = All; }
                field("PP approved user"; Rec."PP approved user") { ApplicationArea = All; }
                field("PP approved date"; Rec."PP approved date") { ApplicationArea = All; }
                field("PP approve comments"; Rec."PP approve comments") { ApplicationArea = All; }

                field("QA approved"; Rec."QA engineer approved") { ApplicationArea = All; }
                field("QA approved user"; Rec."QA approved user") { ApplicationArea = All; }
                field("QA approved date"; Rec."QA engineer approved date") { ApplicationArea = All; }
                field("QA approve comments"; Rec."QA approve comments") { ApplicationArea = All; }

                field("Final decision"; Rec."Final decision") { ApplicationArea = All; }
                field("Final decision user"; Rec."Final approved user") { ApplicationArea = All; }
                field("Final decision date"; Rec."Final decision date") { ApplicationArea = All; }
                field("Final decision comments"; Rec."Final decision comments") { ApplicationArea = All; }

            }

        }

    }

    actions
    {
        area(Processing)
        {
            action("Create backup")
            {
                ApplicationArea = All;
                Image = Database;
                trigger OnAction()
                var
                    UserSetup: Record "User Setup";
                begin
                    UserSetup.Get(UserId);
                    if UserSetup."4M Administrator" then begin
                        createPdfBackup();
                    end else begin
                        Dialog.Message('You have no permission to execute this function!');
                    end;
                end;
            }
        }
    }

    var
        myInt: Integer;

    local procedure createPdfBackup()
    var
        backupLocation: Text[200];
        ChangeDatabase: Record "SEI 4M change request";
        ManSetup: Record "Manufacturing Setup";
        IStream: InStream;
        OStream: OutStream;
        ExportFileName: Text;
        Counter: Integer;
    begin
        //if Dialog.Confirm('This function will create backup from pdf attachment. Befor start please check backup location on manufacturing setup. Do you want execute?') then begin
        ManSetup.Get();
        backupLocation := ManSetup."Backup path";
        ChangeDatabase.Reset();
        Counter := 0;
        if ChangeDatabase.FindSet() then begin
            repeat
                //ChangeDatabase.Get();
                //ChangeDatabase.Get();
                //ExportAllData(ChangeDatabase, ' - WI.pdf');
                ExportFileName := ChangeDatabase."Serial Number" + ' - WI.pdf';
                ChangeDatabase.CalcFields("Work instruction attachment");
                ChangeDatabase."Work instruction attachment".CreateInStream(IStream);
                DownloadFromStream(IStream, '', '', '', ExportFileName);
                Counter := Counter + 1;
            until ChangeDatabase.Next() = 0;
            dialog.Message(Format(Counter));
        end;
        //end;
    end;
}