<cfcomponent>
    <cffunction name="getOptions" access="remote" returnformat="json">
        <cfset options = [
            { "id": 1, "name": "Option 1" },
            { "id": 2, "name": "Option 2" },
            { "id": 3, "name": "Option 3" }
        ]>
        <cfreturn options>
    </cffunction>
</cfcomponent>
