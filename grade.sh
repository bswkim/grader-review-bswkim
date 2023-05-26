CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission # Remove the student's submission if it exists
rm -rf grading-area # Remove the grading area if it exists

mkdir grading-area # Create the grading area

git clone $1 student-submission # Clone the student's submission
echo 'Finished cloning' 

if [ -f student-submission/ListExamples.java ]; then
    echo 'java file found'
    cp student-submission/ListExamples.java grading-area 
    cp TestListExamples.java grading-area
else
    echo 'java file not found'
fi

cp -r lib grading-area
cd grading-area

echo 'Compiling ListExamples.java'
javac -cp $CPATH ListExamples.java
javac -cp $CPATH TestListExamples.java

if [ $? == !0 ]; then
    echo 'Compilation failed.'
    set -e # Exit immediately if a command exits with a non-zero status
fi

#Run the tests and report the grade based on the JUnit output.
echo 'Running tests'
java -cp $CPATH org.junit.runner.JUnitCore TestListExamples

# If the tests pass, then copy the student's submission to the final
# destination
cp ListExamples.java ../student-submission


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
