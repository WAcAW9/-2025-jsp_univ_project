package dto;

public class Food {
    private int foodCode;
    private int spicy, sweet, salty, savory, umami;

    // getter/setter
    public int getFoodCode() { return foodCode; }
    public void setFoodCode(int foodCode) { this.foodCode = foodCode; }

    public int getSpicy() { return spicy; }
    public void setSpicy(int spicy) { this.spicy = spicy; }

    public int getSweet() { return sweet; }
    public void setSweet(int sweet) { this.sweet = sweet; }

    public int getSalty() { return salty; }
    public void setSalty(int salty) { this.salty = salty; }

    public int getSavory() { return savory; }
    public void setSavory(int savory) { this.savory = savory; }

    public int getUmami() { return umami; }
    public void setUmami(int umami) { this.umami = umami; }
}