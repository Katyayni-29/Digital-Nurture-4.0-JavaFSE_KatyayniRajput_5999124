import React from 'react';
import { courses } from './data';

const CourseDetails = () => {
  return (
    <div className="course-details">
      <h1>Course Details</h1>
      {courses.map(course => (
        <div key={course.id}>
          <h3>{course.title}</h3>
          <h4>{course.date}</h4>
        </div>
      ))}
    </div>
  );
};

export default CourseDetails;