report 50037 "4M change report"
{
    DefaultLayout = RDLC;
    RDLCLayout = '.src/rdlc/Report.50035.4M-report.rdlc';
    ApplicationArea = All;
    Caption = '4M Change Request';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("SEI 4M change request"; "SEI 4M change request")
        {
            //RequestFilterFields = "Serial Number";
            column(CompanyName; getCompanyName) { }
            column(Serial_Number; "Serial Number") { }
            column(Status; Status) { }
            column("Area"; "Area") { }
            column(Version; Version) { }
            column(Request_by; "Request by") { }
            column(Request_date; "Request date") { }
            column(Item_number; "Item number") { }
            column(Item_description; "Item description") { }
            column(Man___Machine_description; "Man / Machine description") { }
            column(Type_of_4M_request; "Type of 4M request") { }
            column(Scope_of_4M_request; "Scope of 4M request") { }
            column(Work_order_numner; "Work order numner") { }
            column(Duration_of_4M; "Duration of 4M") { }
            column(Current_regulation; getCurrentRegulation("Serial Number")) { }
            column(Prupose_of_change_with_reason; getChangePrupose("Serial Number")) { }
            column(Customer_name; "Customer name") { }
            column(Customer_item; "Customer item") { }
            column(Special_work_instruction; "Special work instruction") { }
            column(Work_instruction_details; getSpecWorkInstruction("Serial Number")) { }
            column(Production_release; "Production release") { }
            column(Customer_notify; "Customer notify") { }
            column(APQP; APQP) { }
            column(Evaluation_required; "Evaluation required") { }
            column(Waiver; Waiver) { }
            column(Waiver_number; "Waiver number") { }
            column(PCN; PCN) { }
            column(PCN_number; "PCN number") { }
            column(Test_production; "Test production") { }
            column(Test_production_quantity; "Test production quantity") { }
            column(Cost_of_change; "Cost estimation") { }
            column(Unit_of_cost_est_; "Unit of cost est.") { }
            column(DE_approved; "DE approved") { }
            column(DE_approve_comments; "DE approve comments") { }
            column(PE_approved; "PE approved") { }
            column(PE_approve_comments; "PE approve comments") { }
            column(ENG_leader_approved; "ENG leader approved") { }
            column(ENG_approve_comments; "ENG approve comments") { }
            column(PP_approved; "PP approved") { }
            column(PP_approve_comments; "PP approve comments") { }
            column(Prod__manager_approved; "Prod. manager approved") { }
            column(ProdMan_approve_comments; "ProdMan approve comments") { }
            column(QA_engineer_approved; "QA engineer approved") { }
            column(QA_approve_comments; "QA approve comments") { }
            column(Final_decision; "Final decision") { }
            column(Final_decision_comments; "Final decision comments") { }
            column(GetIATFDocNr; GetIATFDocNr()) { }
            column(DE_approved_user; "DE approved user") { }
            column(PE_approved_user; "PE approved user") { }
            column(ENG_leade_user; "ENG leade user") { }
            column(Prod__manager_user; "Prod. manager user") { }
            column(PP_approved_user; "PP approved user") { }
            column(QA_approved_user; "QA approved user") { }
            column(Final_approved_user; "Final approved user") { }
            column(DE_approved_date; "DE approved date") { }
            column(PE_approved_date; "PE approved date") { }
            column(ENG_leader_approved_date; "ENG leader approved date") { }
            column(Prod__manager_approved_date; "Prod. manager approved date") { }
            column(PP_approved_date; "PP approved date") { }
            column(QA_engineer_approved_date; "QA engineer approved date") { }
            column(Final_decision_date; "Final decision date") { }
            column(isPCNAttached; isPCNAttached("Serial Number")) { }
            column(isSpecWIAttached; isSpecWIAttached("Serial Number")) { }
            column(isWaiverAttached; isWaiverAttached("Serial Number")) { }
            column(isMeasureAttached; isMeasureAttached("Serial Number")) { }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }
    labels
    {
        LblTitle = 'Elt??r??si enged??ly k??r??s / 4M change request', Locked = true;
        LblArea = 'Ter??let / Area', Locked = true;
        LblSerialNum = 'Sorsz??m / Number', Locked = true;
        LblRequestDate = 'Ig??nyl??s d??tuma / Requested date', Locked = true;
        LblRequestby = 'Ig??nyl?? neve / Request by', Locked = true;
        LblItem = 'Cikksz??m / Item number', Locked = true;
        LblItemDesc = 'Megnevez??s / Item description', Locked = true;
        Lbl4MType = 'V??lt. eng. t??pusa / 4M change type', Locked = true;
        Lbl4Mcontent = 'V??lt. eng. tartalma / 4M change contents', Locked = true;
        lblWONumber = 'WO sz??ma / WO number', Locked = true;
        LblDuration = 'Id??tartam / Period', Locked = true;
        LblRegulation = 'El????r??s / Regulation', Locked = true;
        LblPrupChange = 'K??rt v??ltoz??s indokl??ssal / Prupose of change with reason', Locked = true;
        LblCustomer = 'Vev?? / Customer', Locked = true;
        LblCustomerItem = 'Vev??i cikksz??m / Customer part number', Locked = true;
        LblAction = 'Akci?? / Action (4M matrix)', Locked = true;
        LblSpecWI = 'Speci??lis munkautas??t??s / Special work instruction', Locked = true;
        LblProdRel = 'Production release', Locked = true;
        LblApqp = 'APQP', Locked = true;
        LblCustNotify = 'Vev?? ??rtes??t??se / Customer notice', Locked = true;
        LblEvalResult = 'Teszt sz??ks??ges / Evaulation result (CPK, dim report, apperance, etc.)', Locked = true;
        LblWaiver = 'Waiver', Locked = true;
        LblPCN = 'PCN', Locked = true;
        LblTestProd = 'Tesztgy??rt??s sz??ks??ges? / Is test prod. necessary?', Locked = true;
        LblTestQty = 'Teszgy??rt??s menny. / Test prod. qty.', Locked = false;
        LblCost = 'K??lts??gvonzat / Cost of change', Locked = true;
        //LblDocNum = 'PM-11-01-02', Locked = true;
        LblManMachineDesc = 'Man / Machine description', Locked = true;
        LblDesignEng = 'Design engineer', Locked = true;
        LblProcEng = 'Process engineer', Locked = true;
        LblLeaderEng = 'Engineering leader', Locked = true;
        LblProdPlan = 'Production planner', Locked = true;
        LblProdMan = 'Production manager', Locked = true;
        LblQaEng = 'Quality engineer', Locked = true;
        LblQaMan = 'Quality manager', Locked = true;
        LblApprove = 'Elfogadva / Approved', Locked = true;
        LblDeni = 'Elutas??tva / Denied', Locked = true;
        LblSign = 'Megjegyz??s / Decision comment', Locked = true;
        LblDate = 'D??tum / Date', Locked = true;
        LblDecision = 'D??nt??s / Decision', Locked = true;
        LblStatus = '??llapot / Status', Locked = true;
        LblUnitofcost = 'V??rhat?? k??lts??g egys. / Unit of cost estim.', Locked = true;
        LblMeasureData = 'M??r??si adatok / Measure data', Locked = true;
        LblAttachmentDesscription = 'A dolumentumhoz felt??lt??tt csatolm??nyok ??sszegz??se / Summary of document attachment', Locked = true;

    }

    var
        ChangeRequest: Record "SEI 4M change request";
        CompanyInfo: Record "Company Information";

    local procedure getCurrentRegulation(SerialNumber: Code[20]): Text
    Var
        CurrRegulation: InStream;
        ReturnStr: Text;
    begin
        ReturnStr := '';
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        ChangeRequest.CalcFields("Current regulation");
        ChangeRequest."Current regulation".CreateInStream(CurrRegulation);
        CurrRegulation.Read(ReturnStr);
        exit(ReturnStr);
    end;

    local procedure getChangePrupose(SerialNumber: Code[20]): Text
    Var
        ChangePrupose: InStream;
        ReturnStr: Text;
    begin
        ReturnStr := '';
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        ChangeRequest.CalcFields("Prupose of change with reason");
        ChangeRequest."Prupose of change with reason".CreateInStream(ChangePrupose);
        ChangePrupose.Read(ReturnStr);
        exit(ReturnStr);
    end;

    local procedure getSpecWorkInstruction(SerialNumber: Code[20]): Text
    Var
        WIDetails: InStream;
        ReturnStr: Text;
    begin
        ReturnStr := '';
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        ChangeRequest.CalcFields("Work instruction details");
        ChangeRequest."Work instruction details".CreateInStream(WIDetails);
        WIDetails.Read(ReturnStr);
        exit(ReturnStr);
    end;

    local procedure getCompanyName(): Text
    var

    begin
        CompanyInfo.Init();
        CompanyInfo.get();
        exit(CompanyInfo.Name);
    end;

    local procedure GetIATFDocNr(): Code[20]
    var
        ManSetup: Record "Manufacturing Setup";
    begin
        ManSetup.Init();
        ManSetup.Get();
        exit(ManSetup."IATF Document number");
    end;

    local procedure isWaiverAttached(SerialNumber: Code[20]): Text
    begin
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        if ChangeRequest."Waiver attachment".HasValue then begin
            exit('Waiver is attached.');
        end else begin
            exit('Waiver is not attached.');
        end;
    end;

    local procedure isPCNAttached(SerialNumber: Code[20]): Text
    begin
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        if ChangeRequest."PCN attachment".HasValue then begin
            exit('PCN is attached.');
        end else begin
            exit('PCN is not attached.');
        end;
    end;

    local procedure isSpecWIAttached(SerialNumber: Code[20]): Text
    begin
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        if ChangeRequest."Work instruction attachment".HasValue then begin
            exit('Work instruction is attached.');
        end else begin
            exit('Work instruction is not attached.')
        end;
    end;

    local procedure isMeasureAttached(SerialNumber: Code[20]): Text
    begin
        ChangeRequest.Init();
        ChangeRequest.Get(SerialNumber);
        if ChangeRequest."Measure attachment".HasValue then begin
            exit('Measure data is attached.');
        end else begin
            exit('Measure data is not attached.')
        end;
    end;
}
//Hiba
//Rendering output for the report failed and the following error occurred: 
//The tablix ???Tablix2??? has a detail member with inner members. Detail members can only contain static inner members.
//Jav??t??sa
//Ha egy alap tablix-ot haszn??lunk az??rt, hogy a nyomtat??si k??p oldalank??nt j??l jelenjen meg ennek a tablixnak
//be kell ??ll??tani a group-j??t a hivatkozott t??bla kulcs??val. 