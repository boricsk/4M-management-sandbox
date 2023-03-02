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
                Enabled = Rec.isHeaderEditable;
                Caption = 'Change request basic data';
                field("4M Number"; Rec."Serial Number")
                {
                    ApplicationArea = All;
                    Caption = 'Number of change request';
                    Enabled = Rec.isFinalApproved;
                }
                field(Status; Rec.Status) { ApplicationArea = All; Editable = false; Caption = 'Status'; }
                field("Scope of 4M request"; Rec."Scope of 4M request") { ApplicationArea = All; Caption = 'Scope of 4M request'; }
                field(Version; Rec.Version) { ApplicationArea = All; Caption = 'Version'; }
                field("Area"; Rec."Area") { ApplicationArea = All; Caption = 'Area'; }
                field("Request by"; Rec."Request by")
                {
                    TableRelation = User."Full Name";
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Request by';
                    trigger OnValidate()
                    begin

                    end;
                }
                field("Request date"; Rec."Request date") { ApplicationArea = All; Editable = false; Caption = 'Request date'; }
                field("Item number"; Rec."Item number")
                {
                    TableRelation = Item."No.";
                    ApplicationArea = All;
                    Caption = 'Item number';


                    trigger OnValidate()
                    var
                        Items: Record Item;
                        ItemRef: Record "Item Reference";
                    begin
                        Items.Init();
                        ItemRef.Init();

                        if (Rec."Scope of 4M request" = Rec."Scope of 4M request"::Material) or (Rec."Scope of 4M request" = Rec."Scope of 4M request"::Method) then begin
                            if Rec."Item number" = '' then begin
                                Dialog.Error(ItemIsMandatory);
                            end;

                            Items.Get(Rec."Item number");
                            Rec."Item description" := Items.Description;
                            ItemRef.SetFilter("Item No.", Rec."Item number");
                            if ItemRef.Find('+') then
                                Rec."Customer item" := ItemRef."Reference No.";


                        end;
                    end;
                }
                field("Item description"; Rec."Item description") { ApplicationArea = All; Editable = false; Caption = 'Item description'; }
                field("Type of 4M request"; Rec."Type of 4M request")
                {
                    ApplicationArea = All;
                    Caption = 'Type of 4M request';

                }
                field("Work order number"; Rec."Work order numner") { ApplicationArea = All; Caption = 'Work order number'; }
                field("Duration of 4M"; Rec."Duration of 4M")
                {
                    ApplicationArea = All;
                    Caption = 'Duration of 4M';

                    trigger OnValidate()
                    begin
                        if Rec."Type of 4M request" = Rec."Type of 4M request"::Permanent then begin
                            Dialog.Error(NoNeedDuration);
                        end;

                        if (Rec."Duration of 4M" = 0D) and (Rec."Type of 4M request" = Rec."Type of 4M request"::Permanent) then begin
                            Dialog.Error(EndDatIsMandatory);
                        end;

                        if Rec."Duration of 4M" > Rec."Request date" + 90 then begin
                            Dialog.Error(WrongDate);
                        end;

                        if Rec."Duration of 4M" < Rec."Request date" then begin
                            Dialog.Error(DatInPast);
                        end;


                    end;


                }
                field("Man / Machine description"; Rec."Man / Machine description") { ApplicationArea = All; Caption = 'Man / Machine description'; }
                field("Machine center"; Rec."Machine center") { ApplicationArea = All; Caption = 'Machine center'; }

            }
            group("Current regulation details")
            {
                Caption = 'Current regulation details';
                Enabled = Rec.isHeaderEditable;
                field("Current regulation"; CurrentRegulation)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Current regulation';
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

            group("Purpose of change")
            {
                Enabled = Rec.isHeaderEditable;
                Caption = 'Purpose of change';

                field("Purpose of change with reason"; ChangePrupose)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Purpose of change';


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
                Enabled = Rec.isFinalApproved;
                Caption = 'Action based on 4M Matrix';
                field("Customer name"; Rec."Customer name")
                {
                    TableRelation = Customer.Name;
                    ApplicationArea = All;
                    Caption = 'Customer name';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
                field("Customer item"; Rec."Customer item") { ApplicationArea = All; Editable = false; Caption = 'Customer item'; }
                field("Special work instruction"; Rec."Special work instruction")
                {
                    ApplicationArea = All;
                    Caption = 'Special work instruction';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
                field("Production release"; Rec."Production release")
                {
                    ApplicationArea = All;
                    Caption = 'Production release';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
                field(APQP; Rec.APQP)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
                field("Special work instruction details"; SpecWorkInst)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                    Caption = 'Special work instruction details';

                    trigger OnValidate()
                    var
                        myOutStream: OutStream;
                    begin

                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            Rec."Work instruction details".CreateOutStream(myOutStream);
                            myOutStream.WriteText(SpecWorkInst);
                        end;
                    end;
                }
            }
            group("Customer notifying")
            {
                Enabled = Rec.isFinalApproved;
                Caption = 'Customer notify';
                field("Customer notify"; Rec."Customer notify")
                {
                    ApplicationArea = All;
                    Caption = 'Customer notify';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            if (Rec.PCN = Rec.PCN::Yes) or (Rec."PCN number" <> '') or (Rec.Waiver = Rec.PCN::Yes) or (Rec."Waiver number" <> '') then
                                if not Rec."Customer notify" then
                                    Dialog.Error(PCN_WaiverAlreadyDefined);
                        end;
                    end;

                }
                field("Evaluation required (Test production)"; Rec."Evaluation required")
                {
                    ApplicationArea = All;
                    Caption = 'Evaulation required';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
                field("Test production quantity"; Rec."Test production quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Test production qty.';
                    Enabled = (Rec."Customer notify") or (Rec.isFinalApproved);
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            if (Rec."Evaluation required" = Rec."Evaluation required"::No) then begin
                                Dialog.Error(NoNeedToFillCustomer);
                                Rec."Test production quantity" := 0;
                            end;
                            if (Rec."Customer notify") and (Rec."Evaluation required" = Rec."Evaluation required"::No) then begin
                                Dialog.Error(EvaulationMustYes);
                                Rec."Test production quantity" := 0;
                            end;
                        end;

                    end;
                }
                field(Waiver; Rec.Waiver)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            if (not Rec."Customer notify") then begin
                                Dialog.Error(NoneedToFillCustNotReq);
                            end;
                            if Rec.PCN = Rec.PCN::Yes then begin
                                Dialog.Error(WaiverMustNo);
                            end;
                            if Rec.Waiver = Rec.Waiver::No then begin
                                Rec."Waiver number" := '';
                            end;
                        end;
                    end;
                }
                field("Waiver number"; Rec."Waiver number")
                {
                    ApplicationArea = All;
                    Caption = 'Waiver number';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            if Rec.PCN = Rec.PCN::Yes then
                                Dialog.Error(PcnMustBeNo);
                            if (Rec.Waiver = Rec.Waiver::No) then begin
                                Dialog.Error(WaiverMustBeYes);
                            end;
                            if (not Rec."Customer notify") and (Rec.Waiver = Rec.Waiver::Yes) then begin
                                Dialog.Error(CustNotyMustOn);
                            end;
                        end;
                    end;
                }
                field(PCN; Rec.PCN)
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            if (not Rec."Customer notify") or (Rec.Waiver = Rec.Waiver::Yes) then begin
                                Dialog.Error(NoNeedFillCustNotReqOrWaiverMustNo);
                            end;
                            if Rec.PCN = Rec.PCN::No then begin
                                Rec."PCN number" := '';
                            end;
                        end;
                    end;
                }
                field("PCN number"; Rec."PCN number")
                {
                    ApplicationArea = All;
                    Caption = 'PCN number';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then begin
                            Dialog.Error(NoPermission);
                        end else begin
                            if (Rec.Waiver = Rec.Waiver::Yes) then begin
                                Dialog.Error(NoNeedFillCustNotReqOrWaiverMustNo);
                            end;
                            if (Rec."Customer notify") and (Rec.PCN = Rec.PCN::No) then begin
                                Dialog.Error(PcnMustBeYes);
                            end;
                            if (not Rec."Customer notify") and (Rec.PCN = Rec.PCN::No) then begin
                                Dialog.Error(CustNotyMustOn);
                            end;
                        end;
                    end;
                }

            }
            group("Cost Estimation")
            {
                Enabled = Rec.isFinalApproved;
                Caption = 'Cost estimation';
                field("Cost of change"; Rec."Cost estimation")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
                field("Unit of cost estimation"; Rec."Unit of cost est.")
                {
                    ApplicationArea = All;
                    Caption = 'Unit of cost estimation';
                    trigger OnValidate()
                    begin
                        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve" or UserSetup."4M Production approve") then
                            Dialog.Error(NoPermission);
                    end;
                }
            }
            group(Decision)
            {
                Caption = 'Decision';
                Enabled = Rec.isFinalApproved;
                group("Design Enginnering")
                {
                    Caption = 'DE decision';
                    field("DE approved"; Rec."DE approved")
                    {
                        ApplicationArea = All;
                        Enabled = Rec.isDEApproved;

                        trigger OnValidate()
                        begin
                            if not UserSetup."4M Design Engineering approve" then begin
                                Dialog.Error(NoPermission);
                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."DE approved" = Rec."DE approved"::Denied) or (Rec."DE approved" = Rec."DE approved"::Approved) then begin
                                        Rec.isDEApproved := false;
                                        Rec.isHeaderEditable := false;
                                        Rec.Status := Rec.Status::"Under Approval";
                                        Rec."DE approved date" := Today();
                                        Rec."DE approved user" := UserId;
                                        if not rec.isFinalNotificationSent then begin
                                            if (Rec."DE approved" <> Rec."DE approved"::Pending) and (Rec."PE approved" <> Rec."PE approved"::Pending) and (rec."PP approved" <> Rec."PP approved"::Pending) and (rec."Prod. manager approved" <> rec."Prod. manager approved"::Pending) and (rec."QA engineer approved" <> rec."QA engineer approved"::Pending) and (rec."ENG leader approved" <> rec."ENG leader approved"::Pending) then begin
                                                sendNotificationToFinalApprover();
                                                Rec.isFinalNotificationSent := true;
                                            end;
                                        end;
                                    end else begin
                                        Rec."DE approved" := Rec."DE approved"::Pending;
                                        Rec."DE approved date" := 0D;
                                        Rec."DE approved user" := '';
                                    end;
                                end;
                            end;
                        end;
                    }
                    field("DE approve comments"; Rec."DE approve comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isDEApproved; Caption = 'DE decision comments'; }
                }
                group("Process Engineering")
                {
                    Caption = 'Process Engineering';
                    field("PE approved"; Rec."PE approved")
                    {
                        ApplicationArea = All;
                        Enabled = Rec.isPEApproved;
                        Caption = 'PE decision';
                        trigger OnValidate()
                        begin
                            if not UserSetup."4M Proc. Engineering approve" then begin
                                Dialog.Error(NoPermission);
                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."PE approved" = Rec."PE approved"::Denied) or (Rec."PE approved" = Rec."PE approved"::Approved) then begin
                                        Rec.isPEApproved := false;
                                        Rec.isHeaderEditable := false;
                                        Rec.Status := Rec.Status::"Under Approval";
                                        Rec."PE approved date" := Today();
                                        Rec."PE approved user" := UserId;
                                        if not rec.isFinalNotificationSent then begin
                                            if (Rec."DE approved" <> Rec."DE approved"::Pending) and (Rec."PE approved" <> Rec."PE approved"::Pending) and (rec."PP approved" <> Rec."PP approved"::Pending) and (rec."Prod. manager approved" <> rec."Prod. manager approved"::Pending) and (rec."QA engineer approved" <> rec."QA engineer approved"::Pending) and (rec."ENG leader approved" <> rec."ENG leader approved"::Pending) then begin
                                                sendNotificationToFinalApprover();
                                                Rec.isFinalNotificationSent := true;
                                            end;
                                        end;
                                    end else begin
                                        Rec."PE approved" := Rec."PE approved"::Pending;
                                        Rec."PE approved date" := 0D;
                                        Rec."PE approved user" := '';
                                    end;
                                end;
                            end;
                        end;
                    }
                    field("PE approve comments"; Rec."PE approve comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isPEApproved; Caption = 'PE decision comments'; }
                }
                group("Engineering leader")
                {
                    Caption = 'Engineering leader';
                    field("ENG leader approved"; Rec."ENG leader approved")
                    {
                        ApplicationArea = All;
                        Enabled = Rec.isENGLeaderApproved;
                        Caption = 'Engineering leader decision';
                        trigger OnValidate()
                        begin
                            if not UserSetup."4M Lead Engineer approve" then begin
                                Dialog.Error(NoPermission);
                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."ENG leader approved" = Rec."ENG leader approved"::Denied) or (Rec."ENG leader approved" = Rec."ENG leader approved"::Approved) then
                                        Rec.isENGLeaderApproved := false;
                                    Rec.isHeaderEditable := false;
                                    Rec.Status := Rec.Status::"Under Approval";
                                    Rec."ENG leader approved date" := Today;
                                    Rec."ENG leade user" := UserId;
                                    if not rec.isFinalNotificationSent then begin
                                        if (Rec."DE approved" <> Rec."DE approved"::Pending) and (Rec."PE approved" <> Rec."PE approved"::Pending) and (rec."PP approved" <> Rec."PP approved"::Pending) and (rec."Prod. manager approved" <> rec."Prod. manager approved"::Pending) and (rec."QA engineer approved" <> rec."QA engineer approved"::Pending) and (rec."ENG leader approved" <> rec."ENG leader approved"::Pending) then begin
                                            sendNotificationToFinalApprover();
                                            Rec.isFinalNotificationSent := true;
                                        end;
                                    end;
                                end else begin
                                    Rec."ENG leader approved" := Rec."ENG leader approved"::Pending;
                                    Rec."ENG leader approved date" := 0D;
                                    Rec."ENG leade user" := UserId;
                                end;
                            end;
                        end;
                    }
                    field("ENG approve comments"; Rec."ENG approve comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isENGLeaderApproved; Caption = 'ENG decision comments'; }
                }
                group("Production planner")
                {
                    Caption = 'Production planner';
                    field("PP approved"; Rec."PP approved")
                    {
                        ApplicationArea = All;
                        Enabled = Rec.isPPApproved;
                        Caption = 'PP decision';
                        trigger OnValidate()
                        begin
                            if not UserSetup."4M Planner approve" then begin
                                Dialog.Error(NoPermission);
                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."PP approved" = Rec."PP approved"::Denied) or (Rec."PP approved" = Rec."PP approved"::Approved) then begin
                                        Rec.isPPApproved := false;
                                        Rec.isHeaderEditable := false;
                                        Rec.Status := Rec.Status::"Under Approval";
                                        Rec."PP approved date" := Today();
                                        Rec."PP approved user" := UserId;
                                        if not rec.isFinalNotificationSent then begin
                                            if (Rec."DE approved" <> Rec."DE approved"::Pending) and (Rec."PE approved" <> Rec."PE approved"::Pending) and (rec."PP approved" <> Rec."PP approved"::Pending) and (rec."Prod. manager approved" <> rec."Prod. manager approved"::Pending) and (rec."QA engineer approved" <> rec."QA engineer approved"::Pending) and (rec."ENG leader approved" <> rec."ENG leader approved"::Pending) then begin
                                                sendNotificationToFinalApprover();
                                                Rec.isFinalNotificationSent := true;
                                            end;
                                        end;
                                    end else begin
                                        Rec."PP approved" := Rec."PP approved"::Pending;
                                        Rec."PP approved date" := 0D;
                                        rec."PP approved user" := '';
                                    end;
                                end;
                            end;
                        end;

                    }
                    field("PP approve comments"; Rec."PP approve comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isPPApproved; Caption = 'PP decision comments'; }
                }
                group("Production manager")
                {
                    Caption = 'Production manager';
                    field("Prod. manager approved"; Rec."Prod. manager approved")
                    {
                        ApplicationArea = All;
                        Enabled = Rec.isProdManApproved;
                        Caption = 'Prod. manager decision';
                        trigger OnValidate()
                        begin
                            if not UserSetup."4M Production approve" then begin
                                Dialog.Error(NoPermission);
                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."Prod. manager approved" = Rec."Prod. manager approved"::Denied) or (Rec."Prod. manager approved" = Rec."Prod. manager approved"::Approved) then
                                        Rec.isProdManApproved := false;
                                    Rec.isHeaderEditable := false;
                                    Rec.Status := Rec.Status::"Under Approval";
                                    Rec."Prod. manager approved date" := Today();
                                    Rec."Prod. manager user" := UserId;
                                    if not rec.isFinalNotificationSent then begin
                                        if (Rec."DE approved" <> Rec."DE approved"::Pending) and (Rec."PE approved" <> Rec."PE approved"::Pending) and (rec."PP approved" <> Rec."PP approved"::Pending) and (rec."Prod. manager approved" <> rec."Prod. manager approved"::Pending) and (rec."QA engineer approved" <> rec."QA engineer approved"::Pending) and (rec."ENG leader approved" <> rec."ENG leader approved"::Pending) then begin
                                            sendNotificationToFinalApprover();
                                            Rec.isFinalNotificationSent := true;
                                        end;
                                    end;
                                end else begin
                                    Rec."Prod. manager approved" := Rec."Prod. manager approved"::Pending;
                                    Rec."Prod. manager approved date" := 0D;
                                    Rec."Prod. manager user" := '';
                                end;
                            end;
                        end;
                    }
                    field("ProdMan approve comments"; Rec."ProdMan approve comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isProdManApproved; Caption = 'Prod. manager decision comments'; }
                }
                group("Quality engineer")
                {
                    Caption = 'Quality engineer';
                    field("QA engineer approved"; Rec."QA engineer approved")
                    {
                        ApplicationArea = All;
                        Enabled = Rec.isQAApproved;
                        Caption = 'QA engineer decision';
                        trigger OnValidate()
                        begin
                            if not UserSetup."4M QA Engineer approve" then begin
                                Dialog.Error(NoPermission);
                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."QA engineer approved" = Rec."QA engineer approved"::Denied) or (Rec."QA engineer approved" = Rec."QA engineer approved"::Approved) then
                                        Rec.isQAApproved := false;
                                    Rec.isHeaderEditable := false;
                                    Rec.Status := Rec.Status::"Under Approval";
                                    Rec."QA engineer approved date" := Today();
                                    Rec."QA approved user" := UserId;
                                    if not rec.isFinalNotificationSent then begin
                                        if (Rec."DE approved" <> Rec."DE approved"::Pending) and (Rec."PE approved" <> Rec."PE approved"::Pending) and (rec."PP approved" <> Rec."PP approved"::Pending) and (rec."Prod. manager approved" <> rec."Prod. manager approved"::Pending) and (rec."QA engineer approved" <> rec."QA engineer approved"::Pending) and (rec."ENG leader approved" <> rec."ENG leader approved"::Pending) then begin
                                            sendNotificationToFinalApprover();
                                            Rec.isFinalNotificationSent := true;
                                        end;
                                    end;
                                end else begin
                                    Rec."QA engineer approved" := Rec."QA engineer approved"::Pending;
                                    Rec."QA engineer approved date" := 0D;
                                    Rec."QA approved user" := '';
                                end;
                            end;
                        end;
                    }
                    field("QA approve comments"; Rec."QA approve comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isQAApproved; Caption = 'QA decision comments'; }
                }
                group("Final decision by QA Manager")
                {
                    Caption = 'Final decision';
                    field("Final decision"; Rec."Final decision")
                    {
                        ApplicationArea = All;
                        Caption = 'Final decision';
                        trigger OnValidate()

                        begin
                            if (Rec."DE approved" = Rec."DE approved"::Pending) or (Rec."PE approved" = Rec."PE approved"::Pending) or (rec."PP approved" = Rec."PP approved"::Pending) or (rec."Prod. manager approved" = rec."Prod. manager approved"::Pending) or (rec."QA engineer approved" = rec."QA engineer approved"::Pending) or (rec."ENG leader approved" = rec."ENG leader approved"::Pending) then begin
                                Dialog.Message(WaitForAllDecision);
                                Rec."Final decision" := Rec."Final decision"::Pending;
                                Rec."Final decision comments" := '';
                                Rec."Final decision date" := 0D;
                                Rec."Final approved user" := '';

                            end else begin
                                if Dialog.Confirm(DecisionConfirm) then begin
                                    if (Rec."Final decision" = Rec."Final decision"::Approved) or (Rec."Final decision" = Rec."Final decision"::Denied)
                                    then begin
                                        Rec.isFinalApproved := false;
                                        Rec.isHeaderEditable := false;
                                        if (Rec."Final decision" = Rec."Final decision"::Approved) then begin
                                            Rec.Status := Rec.Status::Active;
                                            Rec."Final decision date" := Today();
                                            Rec."Final approved user" := UserId;
                                            sendNotificationAfterDecide();
                                        end;
                                        if (Rec."Final decision" = Rec."Final decision"::Denied) then begin
                                            Rec.Status := Rec.Status::Closed;
                                            Rec."Final decision date" := Today();
                                            Rec."Final approved user" := UserId;
                                            sendNotificationAfterDecide();
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    }
                    field("Final decision comments"; Rec."Final decision comments") { ApplicationArea = All; MultiLine = true; Enabled = Rec.isFinalApproved; Caption = 'Final decision comments'; }
                }
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
                Caption = 'Print documents';
                trigger OnAction()
                var
                    ChangeManagement: record "SEI 4M change request";
                begin
                    ChangeManagement.Reset();
                    ChangeManagement.SetRange(ChangeManagement."Serial Number", Rec."Serial Number");
                    Report.RunModal(Report::"4M change report", true, false, ChangeManagement);
                end;
            }
            action("Send notification")
            {
                ApplicationArea = All;
                Image = Email;
                Caption = 'Send notification';
                trigger OnAction()
                begin
                    sendNotification();
                end;
            }
            group("Measure data")
            {
                Image = UnitOfMeasure;
                Caption = 'Measure data';
                action("Upload measure data")
                {
                    ApplicationArea = All;
                    Image = UnitOfMeasure;
                    Caption = 'Upload measure data';
                    trigger OnAction()
                    begin
                        ImportMeasureData();
                    end;
                }

                action("Download measure data")
                {
                    Caption = 'Download measure data';
                    ApplicationArea = All;
                    Image = UnitOfMeasure;
                    trigger OnAction()
                    begin
                        if rec."Measure attachment".HasValue then begin
                            ExportMeasureData();
                        end else begin
                            Dialog.Message(RecordIsEmpty);
                        end;
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
                    Caption = 'Upload waiver';
                    trigger OnAction()

                    begin
                        ImportWaiver();
                    end;
                }

                action("Download waiver")
                {
                    ApplicationArea = All;
                    Image = Account;
                    Caption = 'Download waiver';
                    trigger OnAction()

                    begin
                        if not rec."Waiver attachment".HasValue then begin
                            Dialog.Message(RecordIsEmpty);
                        end else begin
                            ExportWaiver();
                        end;
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
                    Caption = 'Upload PCN';
                    trigger OnAction()
                    begin
                        ImportPCNData();
                    end;
                }

                action("Download PCN")
                {
                    Caption = 'Download PCN';
                    ApplicationArea = All;
                    Image = AssemblyOrder;
                    trigger OnAction()
                    begin
                        if not rec."PCN attachment".HasValue then begin
                            Dialog.Message(RecordIsEmpty);
                        end else begin
                            ExportPCNData();
                        end;
                    end;
                }
            }
            group("Special work instructions")
            {
                Image = Insurance;
                Caption = 'Special work instructions';
                action("Upload Work inst.")
                {
                    ApplicationArea = All;
                    Image = Insurance;
                    Caption = 'Upload WI';
                    trigger OnAction()
                    begin
                        ImportSpecWIData();
                    end;
                }

                action("Download Work inst.")
                {
                    ApplicationArea = All;
                    Image = Insurance;
                    Caption = 'Download WI';
                    trigger OnAction()
                    begin
                        if rec."Work instruction attachment".HasValue then begin
                            ExportSpecWIData();
                        end else begin
                            Dialog.Message(RecordIsEmpty);
                        end;
                    end;
                }
            }
            action("Close document")
            {
                ApplicationArea = All;
                image = Close;
                Caption = 'Close document';
                trigger OnAction()
                begin
                    closeDocument();
                end;
            }
            // action("Test")
            // {
            //     ApplicationArea = All;
            //     image = Close;
            //     trigger OnAction()
            //     begin
            //         sendNotificationToFinalApprover();
            //         sendNotification();
            //         sendNotificationAfterDecide();
            //     end;
            // }
        }


    }
    trigger OnOpenPage()
    begin
        if not UserSetup.get(UserId) then begin
        end else begin
            UserSetup.get(UserId)
        end;

        ManSetup.Get();
        if ManSetup."IATF Document number" = '' then
            Dialog.Message(IATFDocNotExist);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CurrentRegulation := '';
        ChangePrupose := '';
        SpecWorkInst := '';
        Rec."Request by" := UserId;
        Rec."Request date" := Today;
        Rec."Request by GUID" := UserSecurityId();

    end;

    trigger OnDeleteRecord(): Boolean
    begin
        // if UserSetup."4M Administrator" then begin
        //     rec.Delete()
        // end else begin
        //     Dialog.Message('You are not authorized to delete record!');
        // end;
    end;

    trigger OnClosePage()
    begin

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
        PcnMustBeYes: Label 'PCN value must be "yes".';
        NoNeedFillCustNotReqOrWaiverMustNo: Label 'No need to fill it if customer notify is not required or Waiver must be "no"';
        CustNotyMustOn: Label 'Customer notify must be on.';
        WaiverMustBeYes: Label 'Waiwer value must be "yes".';
        PcnMustBeNo: Label 'PCN must be "no"';
        WaiverMustNo: Label 'Waiver value must be "no".';
        NoneedToFillCustNotReq: Label 'No need to fill it if customer notify is not required.';
        EvaulationMustYes: Label 'Evaluation required value must be "yes".';
        NoNeedToFillCustomer: Label 'No need to fill it if customer notify is not required.';
        PCN_WaiverAlreadyDefined: Label 'PCN / Waiver number already define!';
        DatInPast: Label 'Given date is in the past! Good work Dr. Emmett!';
        WrongDate: Label 'Given date is too long. Maximum validity is 90 days.';
        EndDatIsMandatory: Label 'End date of duration is mandatory!';
        NoNeedDuration: Label '4M type is permanent so no need setup duration date.';
        ItemIsMandatory: Label 'Item number is mandatory!';
        NoPermission: Label 'You have no permission to modify this record!';
        WaitForAllDecision: Label 'Please wait for all department decision before final decision.';
        DecisionConfirm: Label 'Are you sure? After decision you can not change!';
        RecordIsEmpty: Label 'Record is empty!';
        IATFDocNotExist: Label 'IATF document number of change request is not defined. Please define it on manufacturing setup page!';
        CurrentRegulation: Text;
        ChangePrupose: Text;
        SpecWorkInst: Text;
        UserSetup: Record "User Setup";
        ManSetup: Record "Manufacturing Setup";
        EmailNotify: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailSubject: Label '4M change';
        EmailBody: Text;
        NotifySentSuccess: Label 'Notification has been sent successfully.';
        NotifyAlreadySent: Label 'Notification has been sent already. Resending is not possible.';
        RecIsNotEmptyConfirm: Label 'Record is not empty! Do you want overwrite existing data?';
        MailLine1: Label 'Dear Recipient,', Locked = true;
        MailLine1_hu: Label 'Tisztelt Címzett!', Locked = true;

        MailLine2: Label 'New 4M change has been issued. Please check it and make your decision in BC change management app.', Locked = true;
        MailLine2_hu: Label 'Új változáskérőt indítottak. Kérem ellenőrizze és hozza meg a döntését a BC változáskérő app-ban.', Locked = true;

        MailLineFinal2: Label '4M change required to final approval. Please check it and make your decision in BC change management app.', Locked = true;
        MailLineFinal2_hu: Label 'A lenti változáskérő a végső döntésre vár, kérem hozza meg a végső döntést!', Locked = true;

        MailLine2AfterDecide: Label 'Your 4M change has been decided. Please check it in BC change management app.', Locked = true;
        MailLine2AfterDecide_hu: Label 'Az Ön által indított változáskérés döntési folyamata befejeződött. A BC változáskezelő app-ban megtekintheti.', Locked = true;

        MailLine3: Label '4M number is : ', Locked = true;
        MailLine3_hu: Label '4M száma : ', Locked = true;

        MailLine4: Label 'Login link : http://seibc.westeurope.cloudapp.azure.com:8080/SEIBCTEST_UA/SignIn?ReturnUrl=%2FSEIBCTEST_UA%2FDefault%3Ftenant%3Ddefault', Locked = true;
        MailLine4_hu: Label 'Belépési link : http://seibc.westeurope.cloudapp.azure.com:8080/SEIBCTEST_UA/SignIn?ReturnUrl=%2FSEIBCTEST_UA%2FDefault%3Ftenant%3Ddefault', Locked = true;

        MailLine5: Label 'Requested by : ', Locked = true;
        MailLine5_hu: Label 'Kérvényezte : ', Locked = true;

        MailLine6: Label 'Final decision : ', Locked = true;
        MailLine6_hu: Label 'Végső döntés : ', Locked = true;

    local procedure sendNotification()
    var
        typeHelper: Codeunit "Type Helper";
        CLFR: Text[2];
        notifyUsers: Record "User Setup";
    begin
        if not Rec.isNotificationSent then begin
            notifyUsers.Init();
            CLFR := typeHelper.CRLFSeparator();
            EmailBody := '';
            EmailBody := MailLine1 + CLFR + MailLine2 + CLFR + MailLine3 + Rec."Serial Number" + CLFR + CLFR + MailLine4 + CLFR + MailLine5 + Rec."Request by" + CLFR + CLFR + CLFR + MailLine1_hu + CLFR + MailLine2_hu + CLFR + MailLine3_hu + Rec."Serial Number" + CLFR + CLFR + MailLine4_hu + CLFR + MailLine5_hu + Rec."Request by";
            notifyUsers.SetFilter("4M Scope", Format(Rec."Area"));

            if notifyUsers.Find('-') then begin
                repeat
                    if (notifyUsers."4M Notify Email" <> '') then begin
                        EmailMessage.Create(notifyUsers."4M Notify Email", EmailSubject, EmailBody);
                        EmailNotify.Send(EmailMessage);
                    end;

                until (notifyUsers.Next = 0)
            end;
            notifyUsers.Init();
            notifyUsers.SetFilter("4M Scope", 'Both');
            if notifyUsers.Find('-') then begin
                repeat
                    if (notifyUsers."4M Notify Email" <> '') then begin
                        //and (notifyUsers."4M Design Engineering approve" or notifyUsers."4M Lead Engineer approve" or notifyUsers."4M Planner approve" or notifyUsers."4M Proc. Engineering approve" or notifyUsers."4M Production approve" or notifyUsers."4M QA Engineer approve" or notifyUsers."4M QA Manager approve")
                        EmailMessage.Create(notifyUsers."4M Notify Email", EmailSubject, EmailBody);
                        EmailNotify.Send(EmailMessage);
                    end;

                until (notifyUsers.Next = 0)
            end;
            Rec.isNotificationSent := true;
            Dialog.Message(NotifySentSuccess);
        end else begin
            Dialog.Message(NotifyAlreadySent);
        end;
    end;

    local procedure ImportWaiver()
    var
        FileMgnt: Codeunit "File Management";
        IStream: InStream;
        OStream: OutStream;
        DialogTitle: Label 'Please select a pdf file to import...';
        TempBLOB: Codeunit "Temp Blob";
        FilePath: Text;
    begin
        if rec."Waiver attachment".Length = 0 then begin
            FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
            TempBLOB.CreateInStream(IStream);
            Rec."Waiver attachment".CreateOutStream(OStream);
            CopyStream(OStream, IStream)
        end else begin
            if Dialog.Confirm(RecIsNotEmptyConfirm) then begin
                Clear(rec."Waiver attachment");
                FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
                TempBLOB.CreateInStream(IStream);
                Rec."Waiver attachment".CreateOutStream(OStream);
                CopyStream(OStream, IStream)
            end;
        end;

    end;

    local procedure ExportWaiver()
    var
        IStream: InStream;
        OStream: OutStream;
        ExportFileName: Text;
    //TempBLOB: Codeunit "Temp Blob";
    begin
        ExportFileName := Rec."Serial Number" + '-Waiver.pdf';
        rec.CalcFields("Waiver attachment");
        rec."Waiver attachment".CreateInStream(IStream);
        DownloadFromStream(IStream, '', '', '', ExportFileName);

    end;

    local procedure ImportMeasureData()
    var
        FileMgnt: Codeunit "File Management";
        IStream: InStream;
        OStream: OutStream;
        DialogTitle: Label 'Please select a pdf file to import...';
        TempBLOB: Codeunit "Temp Blob";
        FilePath: Text;
    begin
        if rec."Measure attachment".Length = 0 then begin
            FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
            TempBLOB.CreateInStream(IStream);
            Rec."Measure attachment".CreateOutStream(OStream);
            CopyStream(OStream, IStream)
        end else begin
            if Dialog.Confirm(RecIsNotEmptyConfirm) then begin
                Clear(rec."Measure attachment");
                FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
                TempBLOB.CreateInStream(IStream);
                Rec."Measure attachment".CreateOutStream(OStream);
                CopyStream(OStream, IStream)
            end;
        end;

    end;

    local procedure ExportMeasureData()
    var
        IStream: InStream;
        OStream: OutStream;
        ExportFileName: Text;
    //TempBLOB: Codeunit "Temp Blob";
    begin
        ExportFileName := Rec."Serial Number" + '-Measure-Data.pdf';
        rec.CalcFields("Measure attachment");
        rec."Measure attachment".CreateInStream(IStream);
        DownloadFromStream(IStream, '', '', '', ExportFileName);
    end;

    local procedure ImportPCNData()
    var
        FileMgnt: Codeunit "File Management";
        IStream: InStream;
        OStream: OutStream;
        DialogTitle: Label 'Please select a pdf file to import...';
        TempBLOB: Codeunit "Temp Blob";
        FilePath: Text;
    begin
        if rec."PCN attachment".Length = 0 then begin
            FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
            TempBLOB.CreateInStream(IStream);
            Rec."PCN attachment".CreateOutStream(OStream);
            CopyStream(OStream, IStream);
        end else begin
            if Dialog.Confirm(RecIsNotEmptyConfirm) then begin
                Clear(rec."PCN attachment");
                FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
                TempBLOB.CreateInStream(IStream);
                Rec."PCN attachment".CreateOutStream(OStream);
                CopyStream(OStream, IStream);
            end;
        end;

    end;

    local procedure ExportPCNData()
    var
        IStream: InStream;
        OStream: OutStream;
        ExportFileName: Text;
    //TempBLOB: Codeunit "Temp Blob";
    begin
        ExportFileName := Rec."Serial Number" + '-PCN-Data.pdf';
        rec.CalcFields("PCN attachment");
        rec."PCN attachment".CreateInStream(IStream);
        DownloadFromStream(IStream, '', '', '', ExportFileName);
    end;

    local procedure ImportSpecWIData()
    var
        FileMgnt: Codeunit "File Management";
        IStream: InStream;
        OStream: OutStream;
        DialogTitle: Label 'Please select a pdf file to import...';
        TempBLOB: Codeunit "Temp Blob";
        FilePath: Text;
    begin
        if rec."Work instruction attachment".Length = 0 then begin
            FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
            TempBLOB.CreateInStream(IStream);
            Rec."Work instruction attachment".CreateOutStream(OStream);
            CopyStream(OStream, IStream);
        end else begin
            if Dialog.Confirm(RecIsNotEmptyConfirm) then begin
                Clear(rec."Work instruction attachment");
                FilePath := FileMgnt.BLOBImport(TempBLOB, DialogTitle);
                TempBLOB.CreateInStream(IStream);
                Rec."Work instruction attachment".CreateOutStream(OStream);
                CopyStream(OStream, IStream);
            end;
        end;

    end;

    local procedure ExportSpecWIData()
    var
        IStream: InStream;
        OStream: OutStream;
        ExportFileName: Text;
    //TempBLOB: Codeunit "Temp Blob";
    begin
        ExportFileName := Rec."Serial Number" + '-Spec-WI-Data.pdf';
        rec.CalcFields("Work instruction attachment");
        rec."Work instruction attachment".CreateInStream(IStream);
        DownloadFromStream(IStream, '', '', '', ExportFileName);
    end;

    local procedure sendNotificationToFinalApprover()
    var
        typeHelper: Codeunit "Type Helper";
        CLFR: Text[2];
        notifyUsers: Record "User Setup";
    begin
        if (UserSetup."4M QA Manager approve") then begin

            CLFR := typeHelper.CRLFSeparator();
            EmailBody := '';
            EmailBody := MailLine1 + CLFR + MailLineFinal2 + CLFR + MailLine3 + Rec."Serial Number" + CLFR + CLFR + MailLine4 + CLFR + MailLine5 + Rec."Request by" + CLFR + CLFR + CLFR + MailLine1_hu + CLFR + MailLineFinal2_hu + CLFR + MailLine3_hu + Rec."Serial Number" + CLFR + CLFR + MailLine4_hu + CLFR + MailLine5_hu + Rec."Request by";
            notifyUsers.Init();
            notifyUsers.Get(UserId);
            if (notifyUsers."4M Notify Email" <> '') then begin
                EmailMessage.Create(notifyUsers."4M Notify Email", EmailSubject, EmailBody);
                EmailNotify.Send(EmailMessage);

            end;

            //Dialog.Message(NotifySentSuccess);
        end else begin
            //Dialog.Message(NotifyAlreadySent);
        end;
    end;

    local procedure sendNotificationAfterDecide()
    var
        typeHelper: Codeunit "Type Helper";
        CLFR: Text[2];
        notifyUsers: Record User;
    begin
        CLFR := typeHelper.CRLFSeparator();
        EmailBody := '';
        EmailBody := MailLine1 + CLFR + MailLine2AfterDecide + CLFR + MailLine3 + Rec."Serial Number" + CLFR + CLFR + MailLine4 + CLFR + MailLine5 + Rec."Request by" + CLFR + MailLine6 + Format(Rec."Final decision") + CLFR + CLFR + CLFR + MailLine1_hu + CLFR + MailLine2AfterDecide_hu + CLFR + MailLine3_hu + Rec."Serial Number" + CLFR + CLFR + MailLine4_hu + CLFR + MailLine5_hu + Rec."Request by" + CLFR + MailLine6_hu + Format(Rec."Final decision");
        notifyUsers.Init();
        notifyUsers.Get(Rec."Request by GUID");
        if (notifyUsers."Contact Email" <> '') then begin
            EmailMessage.Create(notifyUsers."Contact Email", EmailSubject, EmailBody);
            EmailNotify.Send(EmailMessage);
        end else begin
            dialog.Message(UserId + ' has no email address!');
        end;
    end;

    local procedure closeDocument()
    begin
        if not (UserSetup."4M Design Engineering approve" or UserSetup."4M Lead Engineer approve" or UserSetup."4M Planner approve" or UserSetup."4M Proc. Engineering approve" or UserSetup."4M Production approve" or UserSetup."4M QA Engineer approve" or UserSetup."4M QA Manager approve") then begin
            Dialog.Error(NoPermission);
        end else begin
            if Rec.Status = Rec.Status::Active then begin
                if Dialog.Confirm('Do you want close this change request?') then
                    Rec.Status := Rec.Status::Closed;
            end else begin
                Dialog.Error('You can close only Active documents.');
            end;
        end;
    end;

}