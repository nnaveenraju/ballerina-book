import ballerina/io;
import ballerina/math;

type MyErrorDetail record {|
    string message?;
    error cause?;
    string location;
|};

const MY_REASON1 = "MyReason1";
const MY_REASON2 = "MyReason2";

type MyErrorReason1 MY_REASON1;
type MyErrorReason2 MY_REASON2;

type MyError1 error<MyErrorReason1, MyErrorDetail>;
type MyError2 error<MyErrorReason2>;

public function main() {
    string|error result = myErrorProneFunction();
    if (result is string) {
        io:println(result);
    } else if (result is MyError1) {
        io:println("Error1: ", result);
    } else if (result is MyError2) {
        io:println("Error2: ", result);
    }
}

function myErrorProneFunction() returns string|error {
    if (math:random() > 0.5) {
        return error(MY_REASON1, message = "invalid input",
                     location = "MyLocation");
    } else {
        return error(MY_REASON2, message = "invalid operation");
    }
}
