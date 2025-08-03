import React, { useState } from "react";
import CurrencyConvertor from "./CurrencyConvertor";

function App() {
  const [count, setCount] = useState(0);

  const sayHello = () => {
    alert("Hello! This is a static message.");
  };

  const increment = () => {
    setCount(count + 1);
    sayHello();
  };

  const decrement = () => {
    setCount(count - 1);
  };

  const sayWelcome = (msg) => {
    alert(msg);
  };

  const handleClick = (e) => {
    alert("I was clicked");
  };

  return (
    <div className="App" style={{ padding: "20px" }}>
      <h1>Event Examples App</h1>

      <h2>Count: {count}</h2>
      <button onClick={increment}>Increment</button>{" "}
      <button onClick={decrement}>Decrement</button>

      <br /><br />

      <button onClick={() => sayWelcome("Welcome")}>Say Welcome</button>

      <br /><br />

      <button onClick={handleClick}>OnPress</button>

      <br /><br />

      <CurrencyConvertor />
    </div>
  );
}

export default App;