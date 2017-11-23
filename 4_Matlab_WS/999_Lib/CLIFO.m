classdef CLIFO < handle
    properties
        mQ
    end
    
    methods
       function ctor = CLIFO()
           ctor.mQ = {};
       end
       
       function push(this, n)
           this.mQ = [{n}, this.mQ]; 
       end
       
       function [n, flag] = pop(this)
           if(isempty(this.mQ))
               n    = 0;
               flag = 0;
           else
               n       = this.mQ{1};
               this.mQ = this.mQ(2:end);
               flag    = 1;
           end
       end
    end
end