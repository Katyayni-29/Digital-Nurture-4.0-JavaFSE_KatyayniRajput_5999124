import React from 'react';
import './App.css';
import ListofPlayers from './ListofPlayers';
import { IndianPlayers, OddPlayers, EvenPlayers, MergedPlayersList } from './IndianPlayers';

function App() {
  const flag = false; // Change this to 'true' or 'false' to switch between outputs

  return (
    <div className="App">
      {flag ? (
        <div>
          <ListofPlayers />
        </div>
      ) : (
        <div>
          <OddPlayers players={IndianPlayers} />
          <EvenPlayers players={IndianPlayers} />
          <MergedPlayersList players={IndianPlayers} />
        </div>
      )}
    </div>
  );
}
export default App;