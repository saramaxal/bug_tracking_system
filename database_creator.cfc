<cfcomponent  type="text/html charset=cp1251">
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
                    id              INTEGER PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY 
                ,   login           VARCHAR (30) NOT NULL UNIQUE
                ,   name            VARCHAR (30) NOT NULL
                ,   surname         VARCHAR (30) NOT NULL
                ,   password        VARCHAR (32) NOT NULL
            )
        </cfquery>
        <cfquery datasource="cfaccerr">
            INSERT INTO users
                (login, name, surname, password)
            VALUES 
                ('admin', 'Администратор', 'сайта', '#Hash('admin',  'MD5')#'), 
                ('sara', 'Sara', 'Alekseeva', '#Hash('qaz',  'MD5')#'), 
                ('test', 'test', 'test', '#Hash('qaz',  'MD5')#')
        </cfquery>
    </cffunction>

    <cffunction name="CheckUsersTable">
        <cfquery datasource="cfaccerr">
            SELECT id, login, name, surname, password FROM users WHERE 0=1
        </cfquery>
    </cffunction>

    
    
    <!-------------------------------------------
    ---          BUG STATUS TABLE             ---  Новая отменена открыта решена проверена закрыта
    --------------------------------------------->
    <cffunction name="CreateBugStatusTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bug_status (
                    name            VARCHAR(3) PRIMARY KEY NOT NULL 
                ,   view_name       VARCHAR(30) NOT NULL
                ,   ord             INTEGER NOT NULL
            )
        </cfquery>

        <cfquery datasource="cfaccerr">
            INSERT INTO bug_status
                (name, view_name, ord)
            VALUES 
                ('NEW', 'новая', 0),
                ('OPN', 'открытая', 1),
                ('SLV', 'решенная', 2),
                ('CHK', 'проверенная', 3),
                ('CLS', 'закрытая', 4)
        </cfquery>
        <cfquery datasource="cfaccerr">
            INSERT INTO bug_status
                (name, view_name, ord)
            VALUES 
                ('CNL', 'отмененная', 5)
        </cfquery>

    </cffunction>

    <cffunction name="CheckBugStatusTable">
        <cfquery datasource="cfaccerr">
            SELECT name, view_name  FROM bug_status WHERE 0=1
        </cfquery>
    </cffunction>
    
    
    
    
    <!-------------------------------------------
    ---        BUG STATUS Trace TABLE         ---  Новая -> отменена ...
    --------------------------------------------->
    <cffunction name="CreateBugStatusTraceTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bug_status_trace (
                    old_state       VARCHAR(3) NOT NULL REFERENCES bug_status(name)
                ,   new_state       VARCHAR(3) NOT NULL REFERENCES bug_status(name)
            )
        </cfquery>

        <cfquery datasource="cfaccerr">
            INSERT INTO bug_status_trace
                (old_state, new_state)
            VALUES 
                ('NEW', 'OPN'),
                ('NEW', 'CNL'),
                ('OPN', 'SLV'),
                ('OPN', 'CNL'),
                ('SLV', 'OPN')
        </cfquery>
        <cfquery datasource="cfaccerr">
            INSERT INTO bug_status_trace
                (old_state, new_state)
            VALUES 
                ('SLV', 'CHK'),
                ('SLV', 'CNL'),
                ('CHK', 'OPN'),
                ('CHK', 'CLS'),
                ('CHK', 'CNL')
        </cfquery>
        <cfquery datasource="cfaccerr">
            INSERT INTO bug_status_trace
                (old_state, new_state)
            VALUES 
                ('CLS', 'OPN')
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugStatusTraceTable">
        <cfquery datasource="cfaccerr">
            SELECT old_state, new_state FROM bug_status_trace WHERE 0=1
        </cfquery>
    </cffunction>
    
    
    
    <!-------------------------------------------
    ---        BUG URGENCY TABLE              ---
    --------------------------------------------->
    <cffunction name="CreateBugUrgencyTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bug_urgency (
                    name            VARCHAR(3) PRIMARY KEY NOT NULL 
                ,   view_name       VARCHAR(30) NOT NULL
                ,   ord             INTEGER NOT NULL
            )
        </cfquery>

        <cfquery datasource="cfaccerr">
            INSERT INTO bug_urgency
                (name, view_name, ord)
            VALUES 
                ('UR0', 'совсем несрочно', 0),
                ('UR1', 'несрочно', 1),
                ('UR2', 'срочно', 2),
                ('UR3', 'очень срочно', 3)
        </cfquery>

    </cffunction>

    <cffunction name="CheckBugUrgencyTable">
        <cfquery datasource="cfaccerr">
            SELECT name, view_name, ord FROM bug_urgency WHERE 0=1
        </cfquery>
    </cffunction>



    
    <!-------------------------------------------
    ---            BUG TABLE                  ---
    --------------------------------------------->
    <cffunction name="CreateBugTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bug (
                    id              INTEGER PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY 
                ,   user_id         INTEGER NOT NULL REFERENCES users(id)
                ,   datec           TIMESTAMP NOT NULL
                ,   name            VARCHAR(250) NOT NULL
                ,   description     VARCHAR(1000) NOT NULL
                ,   status          VARCHAR(3) NOT NULL REFERENCES bug_status(name)
                ,   urgency         VARCHAR(3) NOT NULL REFERENCES bug_urgency(name)
            )
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugTable">
        <cfquery datasource="cfaccerr">
            SELECT id, user_id, datec, name, description, status, urgency FROM bug WHERE 0=1
        </cfquery>
    </cffunction>

    


    <!-------------------------------------------
    ---            BUG HIST TABLE             ---
    --------------------------------------------->
    <cffunction name="CreateBugHistTable">
        <cfquery datasource="cfaccerr">
            CREATE TABLE bug_hist (
                    id              INTEGER PRIMARY KEY NOT NULL GENERATED ALWAYS AS IDENTITY 
                ,   bug             INTEGER NOT NULL REFERENCES bug(id)
                ,   user_id         INTEGER NOT NULL REFERENCES users(id)
                ,   comment         VARCHAR(1000) NOT NULL
                ,   date            TIMESTAMP NOT NULL
                ,   new_state       VARCHAR(3) REFERENCES bug_status(name)
            )
        </cfquery>
    </cffunction>

    <cffunction name="CheckBugHistTable">
        <cfquery datasource="cfaccerr">
            SELECT id, bug, user_id, comment, date, new_state FROM bug_hist WHERE 0=1
        </cfquery>
    </cffunction>

</cfcomponent>