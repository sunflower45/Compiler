import java.util.*;
import java.lang.*;

public class CompilerHW01 {
	public static void main(String[] args) {
		String input = new String();
		input = "([1].[2]";
		boolean temp = ParenCheck(input);
		System.out.println(temp);
		
	}
	public static boolean ParenCheck(String input){
		String[] temp = new String[input.length()+1];
		boolean chk = true; //if false -> throw err
		for(int i=0;i<input.length();i++){
			temp[i] = input.substring(i, i+1);
		}
		
		///////////parentheses check//////////////
		Stack stk1 = new Stack(); //for ()
		Stack stk2 = new Stack(); //for []
		for(int i=0;i<input.length();i++){
			if(temp[i].equals("(")){
				stk1.push("(");
			}
			else if(temp[i].equals(")")){
				if(stk1.isEmpty()){
					return false;
				}
				else{
					Object item = stk1.pop();
				}
			}
		}
		if(!stk1.isEmpty()){
			return false;
		}
		
		for(int i=0;i<input.length();i++){
			if(temp[i].equals("[")){
				stk2.push("[");
			}
			else if(temp[i].equals("]")){
				if(stk2.isEmpty()){
					return false;
				}
				else{
					Object item = stk2.pop();
				}
			}
		}
		if(!stk2.isEmpty()){
			return false;
		}
		
		return true;
	}
	public static boolean opcheck(String input){
		String[] temp = new String[input.length()+1];
		boolean chk = true; //if false -> throw err
		for(int i=0;i<input.length();i++){
			temp[i] = input.substring(i, i+1);
		}
		/////////////wrong input check////////////
		for(int i=0;i<input.length();i++){
			if(temp[i].equals(".")||temp[i].equals("*")||temp[i].equals("|")||temp[i].equals("^"))
				chk=true;
			else if(temp[i].equals("0")||temp[i].equals("1")||temp[i].equals("2")||temp[i].equals("3")||temp[i].equals("4")||temp[i].equals("5")||temp[i].equals("6")||temp[i].equals("7")||temp[i].equals("8")||temp[i].equals("9")||temp[i].equals("e"))
				chk=true;
			else if(temp[i].equals("(")||temp[i].equals(")")||temp[i].equals("[")||temp[i].equals("]")||temp[i].equals(" "))
				chk=true;
			else
				return false;
		}
		return true;
	}
	public static ArrayList Closure(ArrayList[] NFAtable, ArrayList state, int index){//state 0
		System.out.println("Closure function called");
				
		ArrayList<String> a[] = new ArrayList[4];
		for(int i=0;i<4;i++){
			a[i] = new ArrayList();
		}
		a[0].add("0");
		a[1].add("1");
		a[2].add("2");
		a[3].add("3");
		
		for(int i=0;i<NFAtable.length;i++){
			for(int j=0;j<NFAtable[i].size();j=j+2){
				if(NFAtable[i].get(j).equals("e")){
					a[i].add(NFAtable[i].get(j+1).toString());
				}
			}
		}
		for(int i=0;i<a.length;i++){
			for(int j=1;j<a[i].size();j++){
				for(int k=1;k<a[Integer.parseInt(a[i].get(j))].size();k++){
					a[i].add(a[Integer.parseInt(a[i].get(j))].get(k));
				}
			}
		}
		for(int i=0;i<a.length;i++){
			System.out.print("CLOSURE("+i+")");
			for(int j=0;j<a[i].size();j++){
				System.out.print(" -> ");
				System.out.print(a[i].get(j));
			}
			System.out.print("\n");
		}
		
		ArrayList tmp = new ArrayList();
		tmp = a[index];
		return tmp;
		
	}
	
	public static ArrayList[] NFA_to_DFA(ArrayList[] NFAtable){
		System.out.println("NFA_to_DFA function called");
		ArrayList<String> DFAtable[] = new ArrayList[4];
		for(int i=0;i<4;i++){
			DFAtable[i] = new ArrayList();
		}
		
		ArrayList temp = new ArrayList();
		
		//initial state closure
		for(int i=0;i<Closure(NFAtable, NFAtable[0], 0).size();i++){
			temp = NFAtable[Integer.parseInt(Closure(NFAtable, NFAtable[0], 0).get(i).toString())];
			DFAtable[0].add("0"); //first element
			for(int j=0;j<temp.size();j=+2){
				if(!temp.get(i).equals("e")){
					//if input is number not "e"
					DFAtable[0].add(temp.get(i).toString());
					DFAtable[0].add(temp.get(i+1).toString());
				}
			}
		}
		boolean chk = true;
		for(int i=0;i<4;i++){
			for(int j=2;j<DFAtable[i].size();j=+2){
				for(int k=i-1;k>=0;k--){
					chk = DFAtable[i].get(j).contains(DFAtable[k].get(0));
					if(!chk){
						DFAtable[k+1].add(DFAtable[i].get(j));
						chk = false;
					}
				}
			}
			if(chk==false){
				return DFAtable;
			}
		}
		
		return DFAtable;
	}
}
