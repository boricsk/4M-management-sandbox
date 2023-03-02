codeunit 50023 "SEI Temp Change Request Check"
{
    //TableNo = 50017; <- Ez hibát okozott a várólista futtatásnál (Heti 1X futtatás)
    //Az érvényes ideiglenesen kiadott eltérésik lejárati dátumát kell ellenőrizni
    //Ha lejárt -> email.

    trigger OnRun()
    var
        ChangeRequestDatabase: Record "SEI 4M change request";
        overdueDocuments: Text;
        typeHelper: Codeunit "Type Helper";
        CLFR: Text[2];
        emailBody: Text;
        notifyUsers: Record "User Setup";
        emailMessage: Codeunit "Email Message";
        emailSubject: Label 'Overdue 4M documents list', Locked = true;
        emailNotify: Codeunit Email;
        isRequireToSend: Boolean;

    begin
        isRequireToSend := false;
        CLFR := typeHelper.CRLFSeparator();
        ChangeRequestDatabase.Init();
        notifyUsers.Init();
        if ChangeRequestDatabase.FindSet then begin
            repeat
                if (ChangeRequestDatabase.Status = ChangeRequestDatabase.Status::Active) and (ChangeRequestDatabase."Scope of 4M request" = ChangeRequestDatabase."Type of 4M request"::Temporary) and (ChangeRequestDatabase."Duration of 4M" <= Today) then begin
                    overdueDocuments := overdueDocuments + CLFR + ChangeRequestDatabase."Serial Number";
                    isRequireToSend := true;
                end;
            until ChangeRequestDatabase.Next() = 0;
        end;

        if isRequireToSend then begin
            if notifyUsers.Find('-') then begin
                repeat
                    if (notifyUsers."4M Notify Email" <> '') then begin
                        EmailMessage.Create(notifyUsers."4M Notify Email", EmailSubject, overdueDocuments);
                        EmailNotify.Send(EmailMessage);
                    end;
                until (notifyUsers.Next = 0)
            end;
        end;
    end;



}
