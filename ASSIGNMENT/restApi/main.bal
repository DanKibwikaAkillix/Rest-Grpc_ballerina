import ballerina/http;

service /programmes on new http:Listener(9000) {

    // Retrieve all programmes
    resource function get programmes() returns Programme[] {
        return programmeTable.toArray();
    }

    // Adding a new programe
    resource function post programmes(@http:Payload Programme programme) returns Programme|ConflictingProgrammeCodeError {
        if programmeTable.hasKey(programme.programme_code) {
            return {
                body: {
                    errmsg: string `Conflicting Programme Code: ${programme.programme_code}`
                }
            };
        } else {
            programmeTable.add(programme);
            return programme;
        }
    }

    // Retrieve a specific programme by programme code
    resource function get programmes/[string programme_code]() returns Programme|InvalidProgrammeCodeError {
        Programme? programme = programmeTable[programme_code];
        if programme is () {
            return {
                body: {
                    errmsg: string `Invalid Programme Code: ${programme_code}`
                }
            };
        }
        return programme;
    }

    // Delete a programme by programme code
    resource function delete programmes/[string programme_code]() returns string|InvalidProgrammeCodeError {
        if !programmeTable.hasKey(programme_code) {
            return {
                body: {
                    errmsg: string `Invalid Programme Code: ${programme_code}`
                }
            };
        }
       
        return "Programme deleted successfully.";
    }

    // Retrieve all programmes by faculty 
    resource function get programmes/faculty/[string faculty_name]() returns Programme[] {
        return from Programme p in programmeTable
            where p.faculty == faculty_name
            select p;
    }

}

public type Programme record {|
    readonly string programme_code;
    string programme_title;
    int nqf_level;
    string faculty;
    string department;
    string registration_date;
    Course[] courses;
|};

public type Course record {|
    string course_name;
    string course_code;
    int nqf_level;
|};

public final table<Programme> key(programme_code) programmeTable = table [
    // Add initial programmes here if needed 
];

public type ConflictingProgrammeCodeError record {|
    *http:Conflict;
    ErrorMsg body;
|};

public type InvalidProgrammeCodeError record {|
    *http:NotFound;
    ErrorMsg body;
|};

public type ErrorMsg record {|
    string errmsg;
|};

Utility function to calculate years since a given date 
