import React from 'react';
import { books } from './data';

const BookDetails = () => {
  return (
    <div className="book-details">
      <h1>Book Details</h1>
      <ul>
        {books.map(book => (
          <div key={book.id}>
            <h3>{book.bname}</h3>
            <h4>{book.price}</h4>
          </div>
        ))}
      </ul>
    </div>
  );
};

export default BookDetails;