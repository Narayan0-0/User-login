<cfcomponent>
    <cffunction name="getData" access="remote" returnformat="json">
        <cfset response = { "message": "Hello, World!" }>
        <cfreturn response>
    </cffunction>
</cfcomponent>
