classdef CPath < handle
    properties
       mPath;
       mCost;
       mCostFunctionPtr;
    end
    
    methods
        function ctor = CPath(x_0, costFuncHandle)
            ctor.mPath = x_0;
            ctor.mCost = 0;
            ctor.mCostFunctionPtr = costFuncHandle;
        end
        
        function append(this, x)
            this.mCost = this.mCost + this.mCostFunctionPtr(this.mPath(end), x);
            this.mPath = [this.mPath; x];
        end
        
        function copy_obj = copy(this)
            copy_obj = CPath(this.mPath(1), this.mCostFunctionPtr);
            copy_obj.mPath = this.mPath;
            copy_obj.mCost = this.mCost;
        end

    end
end