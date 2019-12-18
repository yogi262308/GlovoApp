public class IntegerIterator implements Iterable<Integer>, Iterator<Integer> { 
Integer counter; 

public IntegerIterator(Integer counter) {
 this.counter = counter; 
} 

public Boolean hasNext() { return counter > 0; } 

public Integer next() { return counter--; } 

public Iterator<Integer> iterator() { return this; } 
}