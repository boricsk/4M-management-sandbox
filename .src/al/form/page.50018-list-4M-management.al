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
                field("Request by"; Rec."Request by")
                {
                    TableRelation = User."Full Name";
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnValidate()
                    begin
                        //Rec."Request by" := UserId;
                    end;
                }
                field("Request date"; Rec."Request date") { ApplicationArea = All; Editable = false; }
                field("Item number"; Rec."Item number")
                {
                    TableRelation = Item."No.";
                    ApplicationArea = All;

                    trigger OnValidate()
                    var
                        Items: Record Item;
                    begin
                        Items.Get(Rec."Item number");
                        Rec."Item description" := Items.Description;
                    end;
                }
                field("Item description"; Rec."Item description") { ApplicationArea = All; Editable = false; }
                field("Type of 4M request"; Rec."Type of 4M request")
                {
                    ApplicationArea = All;

                }
                field("Work order number"; Rec."Work order numner") { ApplicationArea = All; Caption = 'Work order number'; }
                field("Duration of 4M"; Rec."Duration of 4M")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Type of 4M request" = Rec."Type of 4M request"::Permanent then begin
                            Dialog.Error('4M type is permanent so no need setup duration date.');
                        end;

                        if (Rec."Duration of 4M" = 0D) and (Rec."Type of 4M request" = Rec."Type of 4M request"::Permanent) then begin
                            Dialog.Error('End date of duration is mandatory!');
                        end;

                        if Rec."Duration of 4M" > Rec."Request date" + 90 then begin
                            Dialog.Error('Given date is too long. Maximum validity is 90 days.');
                        end;

                        if Rec."Duration of 4M" < Rec."Request date" then begin
                            Dialog.Error('Given date is in the past! Good work Dr. Emmett!');
                        end;


                    end;


                }
                field("Man / Machine description"; Rec."Man / Machine description") { ApplicationArea = All; }

                // group("Current regulation details")
                // {
                //     field("Current regulation"; CurrentRegulation)
                //     {
                //         ApplicationArea = All;
                //         MultiLine = true;

                //         trigger OnValidate()
                //         var
                //             MyInStream: InStream;
                //             MyOutStream: OutStream;
                //         begin
                //             Rec."Current regulation".CreateOutStream(MyOutStream);
                //             MyOutStream.WriteText(CurrentRegulation);
                //         end;
                //     }

                // }

                // group("Prupose of change")
                // {
                //     field("Prupose of change with reason"; ChangePrupose)
                //     {
                //         ApplicationArea = All;
                //         MultiLine = true;

                //         trigger OnValidate()
                //         var
                //             myOutStream: OutStream;
                //         begin
                //             Rec."Prupose of change with reason".CreateOutStream(myOutStream);
                //             myOutStream.WriteText(ChangePrupose);
                //         end;
                //     }
                // }



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
            }

        }

    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}