<cfcomponent>
    <cffunction name="CreateUser" retutntype="boolean">
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

</cfcomponent>
