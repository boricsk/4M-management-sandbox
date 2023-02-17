page 50017 "Change Management"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "SEI 4M change request";
    Caption = 'Change Management';

    layout
    {
        area(Content)
        {
            group("Change request basic data")
            {
                field("4M Number"; Rec."Serial Number")
                {
                    ApplicationArea = All;
                    Caption = 'Number of change request';
                }
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
                        ItemRef: Record "Item Reference";
                    begin
                        Items.Init();
                        ItemRef.Init();

                        if (Rec."Scope of 4M request" = Rec."Scope of 4M request"::Material) or (Rec."Scope of 4M request" = Rec."Scope of 4M request"::Method) then begin
                            if Rec."Item number" = '' then begin
                                Dialog.Error('Item number is mandatory!');
                            end;

                            Items.Get(Rec."Item number");
                            Rec."Item description" := Items.Description;
                            ItemRef.SetFilter("Item No.", Rec."Item number");
                            if ItemRef.Find('+') then
                                Rec."Customer item" := ItemRef."Reference No.";


                        end;
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

            }
            group("Current regulation details")
            {
                field("Current regulation"; CurrentRegulation)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    var
                        MyInStream: InStream;
                        MyOutStream: OutStream;
                    begin
                        Rec."Current regulation".CreateOutStream(MyOutStream);
                        MyOutStream.WriteText(CurrentRegulation);
                    end;
                }

            }

            group("Prupose of change")
            {
                field("Prupose of change with reason"; ChangePrupose)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    var
                        myOutStream: OutStream;
                    begin
                        Rec."Prupose of change with reason".CreateOutStream(myOutStream);
                        myOutStream.WriteText(ChangePrupose);
                    end;
                }
            }


            group("Action based on 4M Matrix")
            {
                field("Customer name"; Rec."Customer name") { TableRelation = Customer.Name; ApplicationArea = All; }
                field("Customer item"; Rec."Customer item") { ApplicationArea = All; Editable = false; }
                field("Special work instruction"; Rec."Special work instruction") { ApplicationArea = All; }
                field("Production release"; Rec."Production release") { ApplicationArea = All; }
                field(APQP; Rec.APQP) { ApplicationArea = All; }
                field("Special work instruction details"; SpecWorkInst)
                {
                    ApplicationArea = All;
                    MultiLine = true;

                    trigger OnValidate()
                    var
                        myOutStream: OutStream;
                    begin
                        Rec."Work instruction details".CreateOutStream(myOutStream);
                        myOutStream.WriteText(SpecWorkInst);
                    end;
                }
            }
            group("Customer notifying")
            {
                field("Customer notify"; Rec."Customer notify")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if (Rec.PCN = Rec.PCN::Yes) or (Rec."PCN number" <> '') or (Rec.Waiver = Rec.PCN::Yes) or (Rec."Waiver number" <> '') then
                            if not Rec."Customer notify" then
                                Dialog.Error('PCN / Waiver number already define!');
                    end;

                }
                field("Evaluation required (Test production)"; Rec."Evaluation required")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec."Customer notify" then begin
                            //
                        end else begin
                            //Dialog.Error('No need to fill it if customer notify is not required.');
                        end;
                    end;
                }
                field("Test production quantity"; Rec."Test production quantity")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if (Rec."Evaluation required" = Rec."Evaluation required"::No) then begin
                            Dialog.Error('No need to fill it if customer notify is not required.');
                        end;
                        if (Rec."Customer notify") and (Rec."Evaluation required" = Rec."Evaluation required"::No) then begin
                            Dialog.Error('Evaluation required value must be "yes".');
                        end;


                    end;
                }
                field(Waiver; Rec.Waiver)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if (not Rec."Customer notify") then begin
                            Dialog.Error('No need to fill it if customer notify is not required.');
                        end;
                        if Rec.PCN = Rec.PCN::Yes then begin
                            Dialog.Error('Waiver value must be "no".');
                        end;
                        if Rec.Waiver = Rec.Waiver::No then begin
                            Rec."Waiver number" := '';
                        end;
                    end;
                }
                field("Waiver number"; Rec."Waiver number")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if Rec.PCN = Rec.PCN::Yes then
                            Dialog.Error('PCN must be "no"');
                        if (Rec.Waiver = Rec.Waiver::No) then begin
                            Dialog.Error('Waiwer value must be "yes".');
                        end;
                        if (not Rec."Customer notify") and (Rec.Waiver = Rec.Waiver::Yes) then begin
                            Dialog.Error('Customer notify must be on.');
                        end;
                    end;
                }
                field(PCN; Rec.PCN)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if (not Rec."Customer notify") or (Rec.Waiver = Rec.Waiver::Yes) then begin
                            Dialog.Error('No need to fill it if customer notify is not required or Waiver must be "no"');
                        end;
                        if Rec.PCN = Rec.PCN::No then begin
                            Rec."PCN number" := '';
                        end;

                    end;
                }
                field("PCN number"; Rec."PCN number")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if (Rec.Waiver = Rec.Waiver::Yes) then begin
                            Dialog.Error('No need to fill it if customer notify is not required or Waiver must be "no"');
                        end;
                        if (Rec."Customer notify") and (Rec.PCN = Rec.PCN::No) then begin
                            Dialog.Error('PCN value must be "yes".');
                        end;
                        if (not Rec."Customer notify") and (Rec.PCN = Rec.PCN::No) then begin
                            Dialog.Error('Customer notify must be on.');
                        end;
                    end;
                }

            }
            group("Cost Estimation")
            {
                field("Cost of change"; Rec."Cost estimation") { ApplicationArea = All; }
                field("Unit of cost estimation"; Rec."Unit of cost est.") { ApplicationArea = All; }
            }

        }
    }

    actions
    {
        area(Processing)
        {
            action("Print document")
            {
                ApplicationArea = All;
                Image = Report2;

                trigger OnAction()
                var
                    ChangeManagement: record "SEI 4M change request";
                begin
                    ChangeManagement.Reset();
                    ChangeManagement.SetRange(ChangeManagement."Serial Number", Rec."Serial Number");
                    Report.RunModal(Report::"4M change report", true, false, ChangeManagement);
                end;
            }
            group("Measure data")
            {
                Image = UnitOfMeasure;
                action("Upload measure data")
                {
                    ApplicationArea = All;
                    Image = UnitOfMeasure;
                    trigger OnAction()
                    begin

                    end;
                }

                action("Download measure data")
                {
                    ApplicationArea = All;
                    Image = UnitOfMeasure;
                    trigger OnAction()
                    begin

                    end;
                }
            }

            group("Approved document")
            {
                Image = Approve;
                action("Upload approved document")
                {
                    ApplicationArea = All;
                    Image = Approve;
                    trigger OnAction()
                    begin

                    end;
                }

                action("Download approved document")
                {
                    ApplicationArea = All;
                    Image = Approve;
                    trigger OnAction()
                    begin

                    end;
                }
            }
            group("Waivers")
            {
                Image = Account;
                action("Upload waiver")
                {
                    ApplicationArea = All;
                    Image = Account;
                    trigger OnAction()
                    begin

                    end;
                }

                action("Download waiver")
                {
                    ApplicationArea = All;
                    Image = Account;
                    trigger OnAction()
                    begin

                    end;
                }
            }
            group("PCNs")
            {
                image = AssemblyOrder;
                action("Upload PCN")
                {
                    ApplicationArea = All;
                    Image = AssemblyOrder;
                    trigger OnAction()
                    begin

                    end;
                }

                action("Download PCN")
                {
                    ApplicationArea = All;
                    Image = AssemblyOrder;
                    trigger OnAction()
                    begin

                    end;
                }
            }
            group("Special work instructions")
            {
                Image = Insurance;
                action("Upload Work inst.")
                {
                    ApplicationArea = All;
                    Image = Insurance;
                    trigger OnAction()
                    begin

                    end;
                }

                action("Download Work inst.")
                {
                    ApplicationArea = All;
                    Image = Insurance;
                    trigger OnAction()
                    begin

                    end;
                }
            }
        }


    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrentRegulation := '';
        ChangePrupose := '';
        SpecWorkInst := '';
        Rec."Request by" := UserId;
        Rec."Request date" := Today;
    end;



    trigger OnAfterGetRecord()
    var
        MyInStreamCurr: InStream;
        MyinStreamPrup: InStream;
        MyInStreamWI: InStream;
    begin
        CurrentRegulation := '';
        ChangePrupose := '';
        SpecWorkInst := '';
        Rec.CalcFields("Current regulation");
        Rec.CalcFields("Prupose of change with reason");
        Rec.CalcFields("Work instruction details");
        if Rec."Current regulation".HasValue or
            Rec."Prupose of change with reason".HasValue or
            Rec."Work instruction details".HasValue
            then begin

            Rec."Current regulation".CreateInStream(MyInStreamCurr);
            Rec."Prupose of change with reason".CreateInStream(MyInStreamPrup);
            Rec."Work instruction details".CreateInStream(MyInStreamWI);
            MyInStreamCurr.ReadText(CurrentRegulation);
            MyinStreamPrup.ReadText(ChangePrupose);
            MyInStreamWI.ReadText(SpecWorkInst)

        end;

    end;

    var
        myInt: Integer;
        blobVarText: Text;
        CurrentRegulation: Text;
        ChangePrupose: Text;
        SpecWorkInst: Text;
    //NoSeriesMgmnt: Codeunit NoSeriesManagement;
}