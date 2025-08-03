import React, { Component } from 'react';
import './App.css';

// Components for Greetings
function UserGreeting() {
  return <h1 className="greeting-text">Welcome back</h1>;
}

function GuestGreeting() {
  return <h1 className="greeting-text">Please sign up.</h1>;
}

// Components for Buttons
function LoginButton(props) {
  return (
    <button className="app-button login-button" onClick={props.onClick}>
      Login
    </button>
  );
}

function LogoutButton(props) {
  return (
    <button className="app-button logout-button" onClick={props.onClick}>
      Logout
    </button>
  );
}

// Main component with conditional rendering
class App extends Component {
  constructor(props) {
    super(props);
    this.state = { isLoggedIn: false };
  }

  handleLoginClick = () => {
    this.setState({ isLoggedIn: true });
  };

  handleLogoutClick = () => {
    this.setState({ isLoggedIn: false });
  };

  render() {
    const { isLoggedIn } = this.state;

    return (
      <div className="App">
        <div className="card">
          {isLoggedIn ? <UserGreeting /> : <GuestGreeting />}
          {isLoggedIn ? (
            <LogoutButton onClick={this.handleLogoutClick} />
          ) : (
            <LoginButton onClick={this.handleLoginClick} />
          )}
        </div>
      </div>
    );
  }
}

export default App;