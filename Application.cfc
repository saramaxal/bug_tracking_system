<cfcomponent>
<cfset This.name = "BugTrackingSystem">
<cfset This.clientmanagement="True">
<cfset This.loginstorage="Session">
<cfset This.sessionmanagement="True">
<cfset This.sessiontimeout="#createtimespan(0,0,10,0)#">
<cfset This.applicationtimeout="#createtimespan(5,0,0,0)#">
<cfset This.ormenabled="True">
<cfset This.datasource="cfaccerr">


<cffunction name="onRequestStart">
<!--- onSessionStart body goes here --->
<!--cfset Request.theFunctionName=This.theFunctionName-->
    <cfif IsDefined("logout")> 
        <cfset StructClear(Session)>
    </cfif>

    <cfscript>
        SetEncoding("url", "cp1251");
        SetEncoding("form", "cp1251");
    </cfscript>
    
    <cflogin>
        <cfif NOT (IsDefined("login") && IsDefined("password"))> 
            <cfinclude template="authorization.cfm"> 
            <cfabort> 
        <cfelse> 
            <cfset pass = Hash("#password#",  "MD5")>
            <cfquery name="qUser" datasource="cfaccerr">
                SELECT max(id) as id, count(1) as cnt FROM users WHERE login='#login#' AND password='#pass#'
            </cfquery>
            <cfif #qUser.cnt# EQ 1>
                <cfloginuser name="#login#" Password = "#pass#" roles="">
                <cfset Session.user_id="#qUser.id#">
            <cfelse>
                <cfset auth_err=1>
                <cfinclude template="authorization.cfm"> 
                <cfabort> 
            </cfif>
            <!--roles="#loginQuery.Roles#"-->
        </cfif> 
    </cflogin>
</cffunction>


<cffunction name="CheckFunc">
    <cfargument name="tryF" required="true" />
    <cfargument name="callF" required="true" />
    <cftry>
        <cfscript>
            tryF();
        </cfscript>
    <cfcatch type="any">
        <cfscript>
            callF();
        </cfscript>
    </cfcatch>   
    </cftry>
</cffunction>

<cfscript>
    db_creator = new database_creator();
    // db_creator.DropTable("bug_hist");
    // db_creator.DropTable("bug");
    // db_creator.DropTable("bug_urgency");
    // db_creator.DropTable("bug_status_trace");
    // db_creator.DropTable("bug_status");
    // db_creator.DropTable("users");
    CheckFunc(db_creator.CheckUsersTable, db_creator.CreateUsersTable);
    CheckFunc(db_creator.CheckBugStatusTable, db_creator.CreateBugStatusTable);
    CheckFunc(db_creator.CheckBugStatusTraceTable, db_creator.CreateBugStatusTraceTable);
    CheckFunc(db_creator.CheckBugUrgencyTable, db_creator.CreateBugUrgencyTable);
    CheckFunc(db_creator.CheckBugTable, db_creator.CreateBugTable);
    CheckFunc(db_creator.CheckBugHistTable, db_creator.CreateBugHistTable);
</cfscript>
    
</cfcomponent>