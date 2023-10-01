<cfcomponent >
    <cffunction name="DropTable">
        <cfargument name="tabname" required="true" />
        <cfquery datasource="cfaccerr">
            DROP TABLE #tabname#
        </cfquery>
    </cffunction>
    

    <!-------------------------------------------
    ---            USERS TABLE                ---
    --------------------------------------------->
    <cffunction name="CreateUsersTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE users (
                    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY 
                ,   login           VARCHAR (30) NOT NULL UNIQUE
                ,   name            VARCHAR (30) NOT NULL
                ,   surname         VARCHAR (30) NOT NULL
                ,   password        VARCHAR (32) NOT NULL
            )
        </cfquery>
        <cfset pass=Hash('admin',  'MD5')>
        <cfquery datasource="cfaccerr">
            INSERT INTO users
                (login, name, surname, password)
            VALUES 
                ('admin', 'Администратор', 'сайта', '#pass#')
        </cfquery>
    </cffunction>

    <cffunction name="CheckUsersTable">
        <cfquery datasource="cfaccerr">
            SELECT id, login, name, surname, password FROM users WHERE 0=1
        </cfquery>
    </cffunction>

    
    <!-------------------------------------------
    ---            BUG TABLE                  ---
    --------------------------------------------->
    <cffunction name="CreateBugTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bug (
                    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY 
            )
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugTable">
        <cfquery datasource="cfaccerr">
            SELECT id FROM bug WHERE 0=1
        </cfquery>
    </cffunction>

    
    
    <!-------------------------------------------
    ---            BUG HIST TABLE             ---
    --------------------------------------------->
    <cffunction name="CreateBugHistTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bughist (
                    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY 
            )
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugHistTable">
        <cfquery datasource="cfaccerr">
            SELECT id FROM bughist WHERE 0=1
        </cfquery>
    </cffunction>

    
    
    
    <!-------------------------------------------
    ---          BUG STATUS TABLE             ---  Новая отменена открыта решена проверена закрыта
    --------------------------------------------->
    <cffunction name="CreateBugStatusTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bugstatus (
                    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY 
            )
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugStatusTable">
        <cfquery datasource="cfaccerr">
            SELECT id FROM bugstatus WHERE 0=1
        </cfquery>
    </cffunction>
    
    
    
    
    <!-------------------------------------------
    ---        BUG STATUS Trace TABLE         ---  Новая -> отменена ...
    --------------------------------------------->
    <cffunction name="CreateBugStatusTraceTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bugstatustrace (
                    id              INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY 
            )
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugStatusTraceTable">
        <cfquery datasource="cfaccerr">
            SELECT id FROM bugstatustrace WHERE 0=1
        </cfquery>
    </cffunction>

</cfcomponent>