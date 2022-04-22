var XMLParser = new DOMParser();

let student_name = document.getElementById('student name');
let trace = document.getElementById('trace');
let dir = null;
let d = document.getElementById('input').addEventListener('change',
(e) => {
   dir = e;
})

var next = document.getElementById('next');
var previous = document.getElementById('previous');

next.addEventListener('click', goNext);
previous.addEventListener('click', goPrevious);

let student_i = 0;

function goNext() {
    student_i = (student_i + 1) % dir.target.files.length;

    update_name();
    update_trace();
}

function goPrevious() {
    student_i -= 1;
    if (student_i < 0)
        student_i = dir.target.files.length - 1;

    update_name();
    update_trace();
}

function update_name() {
    student_name.innerHTML = dir.target.files[student_i].name;
}

function update_trace() {
    dir.target.files[student_i].text()
    .then(resolve=>{
        resolve = resolve.replace(/\n/g, "<br />");
        var xmlDoc = XMLParser.parseFromString(resolve, "text/xml");
        trace.innerHTML = resolve;
    }).finally(trace_text);

}

function trace_text() {
    document.querySelectorAll("testsuite").forEach( function(ts){
        const testSuiteName = ts.getAttribute("name");
        ts.prepend(testSuiteName);
        for (let i = 0; i < ts.children.length; i++) {
            const testCase = ts.children[i];
            for (let j = 0; j < testCase.children.length; j++) {
                const child = testCase.children[j];
                if (child.tagName == "FAILURE")
                    testCase.setAttribute('failure', 'true');

            }
            // const testCaseFailure = testCase.children("FAILURE");
            // if (testCaseFailure != undefined) {
            //     console.log(testCaseFailure);
            //     console.log(testCaseFailure.tagName);
            // }
            testCase.append(testCase.getAttribute("name"));
        }
    });
}
