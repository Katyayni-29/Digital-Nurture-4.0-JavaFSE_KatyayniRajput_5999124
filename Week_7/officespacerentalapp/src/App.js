import React from 'react';
import './App.css';
import officeImage from './office.jpg'; 

const office = {
  name: "DBS",
  rent: 50000,
  address: 'Chennai'
};

const officeSpaces = [
  { name: "Cognizant", rent: 75000, address: 'Bangalore' },
  { name: "Infosys", rent: 55000, address: 'Hyderabad' },
  { name: "Wipro", rent: 65000, address: 'Pune' }
];

function App() {
  const rentStyle = (rent) => ({
    color: rent < 60000 ? 'red' : 'green'
  });

  return (
    <div className="App">
      <h1>Office Space, at Affordable Range</h1>

      <img src={officeImage} width="25%" height="25%" alt="Modern office space" />

      <h2>Name: {office.name}</h2>
      <h3 style={rentStyle(office.rent)}>Rent: Rs. {office.rent}</h3>
      <h3>Address: {office.address}</h3>

      <hr />

      <h2>Other Office Spaces</h2>
      {officeSpaces.map((item) => (
        <div key={item.name}>
          <h3>Name: {item.name}</h3>
          <h4 style={rentStyle(item.rent)}>Rent: Rs. {item.rent}</h4>
          <h4>Address: {item.address}</h4>
          <hr />
        </div>
      ))}
    </div>
  );
}

export default App;