import React from 'react';
import { blogs } from './data';

const BlogDetails = () => {
  return (
    <div className="blog-details">
      <h1>Blog Details</h1>
      {blogs.map(blog => (
        <div key={blog.id}>
          <h3>{blog.title}</h3>
          <h4>{blog.author}</h4>
          <p>{blog.content}</p>
        </div>
      ))}
    </div>
  );
};

export default BlogDetails;