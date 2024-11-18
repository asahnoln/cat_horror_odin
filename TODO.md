# TODO

## Dev flow

- [ ] Rules API
- [ ] main proc using rules api to play a game using code
- [ ] Media to play: terminal
- [ ] Media to play: 2d

## 2D

- [ ] Move in 2d space (left -1px, right +1px)
- [ ] Cat to be a small square
- [ ] Owner to be a big square
- [ ] Owner walks to cat's position
- [ ] When owner intersects with cat - stop

## Rules

### Start with

- [x] Cat has 9 lives
- [x] Cat can accomplish a goal (maybe eat its food)
- [ ] Cat can move

- [ ] An Owner has its own goals
- [ ] Arthur (first type of owner) wants to cuddle the cat
  - [ ] For that he has a goal to search for the cat
    - [ ] To do that he searches in random places (walks to one place, looks, walks to another etc)
- [ ] When Arthur sees the cat, he starts following it
- [ ] When Arthur in close proximity to the cat, he starts cuddling it
- [ ] When the cat is cuddles, the cat loses a life

- [ ] Game restarts the level when cat loses one life
- [ ] Game ends when all lives are exhausted
- [ ] Game level finishes when all goals are accomplished

### Implement

- [ ] Cat can jump
- [ ] Cat can hide in hiding spots
- [ ] Cat can meows
- [ ] Cat temporarily cringe in its spot to avoid owners hands
- [ ] Cat can scratch to avoid being cuddled by the owner (maybe limited times)
- [ ] Cat can move objects, e.g. to throw something off an edge, so that an object makes a souns and lures owner.

- [ ] Owner can see the cat at a certain distance and then his goal is to catch it
- [ ] Owner hears sounds and goes to the source
- [ ] Owner can catch the cat
- [ ] Owner can try to reach the cat in its hiding spot (if seen)
- [ ] Owner can lose track of the cat

- [ ] Game commands (mapped to vendor lib enums)

## Ideas

Horror game about cat.

Cat runs towards a goal (to eat maybe) and then returns home (to its main hiding spot).

Cat owners are enemies who wants to cuddle the cat.

### Events

- [ ] Castration: we must save our balls
- [ ] Disensection: danger zones?
- [ ] Guests: children!
- [ ] If you do enough damage (storywise or somehow else?) to one owner, he gives you to other owner with different set of rules
- [ ] Owner want to give the pill to the cat
- [ ] Owner wants to heal cat's leg

### Characters

- [ ] Different owners - 1 cuddles, 2 takes to castration
- [ ] Owners might allow or prohibit different zones for the cat

### Locations

- [ ] Mouse shop for the cat?
- [ ] Cat tray (a goal connected to it?)

### Items

- [ ] Cucumber which scares the cat
