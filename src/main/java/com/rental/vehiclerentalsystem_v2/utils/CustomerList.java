package com.rental.vehiclerentalsystem_v2.utils;
import com.rental.vehiclerentalsystem_v2.customer.Customer;

public class CustomerList {
    private Customer[] elements;
    private int size;
    private int capacity;

    public CustomerList() {
        this.capacity = 10;
        this.elements = new Customer[capacity];
        this.size = 0;
    }

    public void add(Customer customer) {
        if (size == capacity) {
            growArray();
        }
        elements[size] = customer;
        size++;
    }

    public Customer get(int index) {
        if (index < 0 || index >= size) {
            throw new IndexOutOfBoundsException("Index out of bounds!");
        }
        return elements[index];
    }

    public int size() {
        return size;
    }

    private void growArray() {
        capacity = capacity * 2;
        Customer[] newArray = new Customer[capacity];

        for (int i = 0; i < size; i++) {
            newArray[i] = elements[i];
        }
        elements = newArray;
    }
}
