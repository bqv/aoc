use std::io::{self, BufRead};

#[derive(PartialEq, Eq, Clone, Copy)]
struct Vector {
    x: i32,
    y: i32,
}

#[derive(PartialEq, Eq, Clone, Copy)]
enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(PartialEq, Eq, Clone, Copy)]
enum Turn {
    Left,
    Right,
}

struct Operation {
    turn: Turn,
    steps: u32,
}

struct State {
    pos: Vec<Vector>,
    dir: Direction,
    result: Option<i32>,
}

fn exec(state: State, op: Operation) -> State {
    use Turn::*;
    let new_dir = match op.turn {
        Left => left(state.dir),
        Right => right(state.dir),
    };
    let mut pos_vec = state.pos;
    for _ in 0..op.steps {
        let pos = step(pos_vec.last().unwrap(), new_dir);
        let seen = pos_vec.iter().position(|&r: &Vector| r == pos).is_some();
        pos_vec.push(pos);
        if seen { 
            let dist = pos.x.abs()+pos.y.abs();
            return State {pos:pos_vec, dir:new_dir, result:Some(dist)}
        };
    };
    State {pos:pos_vec, dir:new_dir, result:None}
}

fn step(pos: &Vector, dir: Direction) -> Vector {
    use Direction::*;
    let &Vector {x, y} = pos;
    match dir {
        North => Vector {x:x, y:y+1},
        East =>  Vector {x:x+1, y:y},
        South => Vector {x:x, y:y-1},
        West =>  Vector {x:x-1, y:y},
    }
}

fn right(dir: Direction) -> Direction {
    use Direction::*;
    match dir {
        North => East,
        East => South,
        South => West,
        West => North,
    }
}

fn left(dir: Direction) -> Direction {
    use Direction::*;
    match dir {
        North => West,
        East => North,
        South => East,
        West => South,
    }
}

fn convert(cmd: &str) -> Operation {
    let mut string = String::new();
    string.push_str(cmd);
    let turn = match string.remove(0) {
        'L' => Some(Turn::Left),
        'R' => Some(Turn::Right),
        _ => None,
    }.unwrap();
    let steps: u32 = string.parse().unwrap();
    Operation {turn:turn, steps:steps}
}

fn parse(string: String) -> Vec<Operation> {
    let mut vec = Vec::new();
    for cmd in string.split(",") {
        vec.push(convert(cmd.trim()));
    };
    vec
}

fn readln() -> String {
    let stdin = io::stdin();
    let line = stdin.lock()
        .lines()
        .next()
        .expect("there was no next line")
        .unwrap();
    line
}

fn main() {
    println!("hi");
    let start = State {pos:vec![Vector {x:0, y:0}], dir:Direction::North, result:None};
    let mut state = start;
    let code = parse(readln());
    for op in code {
        state = exec(state, op);
        match state.result {
            Some(distance) => {
                println!("{}", distance);
                return;
            }
            None => continue,
        }
    };
}

