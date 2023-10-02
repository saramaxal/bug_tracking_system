<cfcomponent>
<cfcontent type="text/html charset=cp1251">
    <cffunction name="CreateUser" returntype="boolean">
        <cfargument name="login" type="string" required="true" />
        <cfargument name="name" type="string" required="true" />
        <cfargument name="surname" type="string" required="true" />
        <cfargument name="password" type="string" required="true" />

        <cftry>
            <cfset pass=Hash('#password#',  'MD5')>
            <cfquery datasource="cfaccerr">
                INSERT INTO users
                    (login, name, surname, password)
                VALUES 
                    ('#login#', '#name#', '#surname#', '#pass#')
            </cfquery>
        <cfcatch type="any">
            <cfreturn false>
        </cfcatch>
        </cftry>
        
        <cfreturn true>
    </cffunction>

    <cffunction name="CreateBug" returntype="boolean">
        <cfargument name="name" type="string" required="true" />
        <cfargument name="description" type="string" required="true" />
        <cfargument name="urgency" type="string" required="true" />

        <cftry>
            <cfquery datasource="cfaccerr">
                INSERT INTO bug
                    (user_id, datec, name, description, status, urgency)
                VALUES 
                    (#Session.user_id#, #Now()#, '#name#', '#description#', 'NEW', '#urgency#')
            </cfquery>
        <cfcatch type="any">
            <cfreturn false>
        </cfcatch>
        </cftry>
        
        <cfreturn true>
    </cffunction>

    <cffunction name="ChangeBug" returntype="boolean">
        <cfargument name="bug_id" type="string" required="true" />
        <cfargument name="name" type="string" required="true" />
        <cfargument name="description" type="string" required="true" />
        <cfargument name="urgency" type="string" required="true" />

        <cftry>
            <cfquery datasource="cfaccerr">
                UPDATE bug
                SET
                        name='#name#'
                    ,   description='#description#'
                    ,   urgency='#urgency#'
                WHERE id=#bug_id#
            </cfquery>
        <cfcatch type="any">
            <cfreturn false>
        </cfcatch>
        </cftry>
        
        <cfreturn true>
    </cffunction>

    <cffunction name="CreateBugHist" returntype="boolean">
        <cfargument name="bug_id" type="string" required="true" />
        <cfargument name="comment" type="string" required="true" />
        <cfargument name="state" type="string" required="true" />

        <cftry>
            <cfquery datasource="cfaccerr">
                INSERT INTO bug_hist
                    (bug, user_id, date, comment, new_state)
                VALUES 
                    (#bug_id#, #Session.user_id#, #Now()#, '#comment#', #state EQ "NULL" ? "NULL" : "'"&state&"'"#)
            </cfquery>
        <cfcatch type="any">
            <cfreturn false>
        </cfcatch>
        </cftry>
        
        <cfreturn true>
    </cffunction>


    <cffunction name="GetBugUrgencies" output="yes" returntype="query">
        <cfquery name="BugUrgency" datasource="cfaccerr">
            SELECT name, view_name FROM bug_urgency ORDER BY ord
        </cfquery>
        <cfreturn #BugUrgency#>
    </cffunction>


    <cffunction name="GetBugStatusTraces" output="yes" returntype="query">
        <cfargument name="StatusFrom" type="string" required="true" />

        <cfquery name="BugStatuses" datasource="cfaccerr">
            SELECT  
                s.name, s.view_name 
            FROM bug_status as s, bug_status_trace as t 
            WHERE s.name=t.new_state AND t.old_state='#StatusFrom#'
            ORDER BY s.ord
        </cfquery>
        <cfreturn #BugStatuses#>
    </cffunction>

    <cffunction name="GetBugs" output="yes" returntype="query">
        <cfargument name="bug_id" type="string" required="no" default="0" />

        <cfquery name="bugs" datasource="cfaccerr">
            SELECT * FROM 
            (SELECT
                id
                , (SELECT name||' '||SUBSTR(surname, 1, 1) FROM users WHERE users.id=b.user_id) as username
                , (SELECT name||' '||surname FROM users WHERE users.id=b.user_id) as userfullname
                , datec
                , COALESCE((SELECT max(date) FROM bug_hist WHERE bug_hist.bug=b.id), datec)
                    as datee
                , name
                , description
                , status as status_name
                , (SELECT view_name FROM bug_status WHERE bug_status.name=b.status) as status
                , urgency as urgency_name
                , (SELECT view_name FROM bug_urgency WHERE bug_urgency.name=b.urgency) as urgency
            FROM bug as b WHERE 1=1 AND b.id=#bug_id EQ "0" ? "b.id" : bug_id#
            ) as sel ORDER BY datee DESC
        </cfquery>
        <cfreturn #bugs#>
    </cffunction>

    
    <cffunction name="GetBugHist" output="yes" returntype="query">
        <cfargument name="bug_id" type="string" required="true" />

        <cfquery name="bugsh" datasource="cfaccerr">
            SELECT
                id
                , bug
                , user_id
                , (SELECT name||' '||surname FROM users WHERE users.id=b.user_id) as username
                , date
                , comment
                , (SELECT view_name FROM bug_status WHERE bug_status.name=b.new_state) as status
                , new_state as status_name
            FROM bug_hist as b WHERE b.bug=#bug_id#
            ORDER BY date
        </cfquery>
        <cfreturn #bugsh#>
    </cffunction>

</cfcontent>
</cfcomponent>